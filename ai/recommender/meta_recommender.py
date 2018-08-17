"""
Recommender system for Penn AI.
"""
import pandas as pd
import json 
import urllib.request, urllib.parse
from .base import BaseRecommender
from ..metalearning import get_metafeatures
from xgboost import XGBClassifier
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
from sklearn.pipeline import Pipeline
import numpy as np
from collections import defaultdict, OrderedDict
from ..db_utils import get_all_ml_p_from_db  
import pdb

class MetaRecommender(BaseRecommender):
    """Penn AI meta recommender.

    Recommends machine learning algorithms and parameters based on their average performance
    across all evaluated datasets.

    Parameters
    ----------
    ml_type: str, 'classifier' or 'regressor'
        Recommending classifiers or regressors. Used to determine ML options.

    metric: str (default: accuracy for classifiers, mse for regressors)
        The metric by which to assess performance on the datasets.

    """

    def __init__(self, ml_type='classifier', metric=None, db_path='',api_key='', ml_p=None):
        """Initialize recommendation system."""
        if ml_type not in ['classifier', 'regressor']:
            raise ValueError('ml_type must be "classifier" or "regressor"')

        self.ml_type = ml_type

        if metric is None:
            self.metric = 'accuracy' if self.ml_type == 'classifier' else 'mse'
        else:
            self.metric = metric
        # path for grabbing dataset metafeatures
        self.mf_path = '/'.join([db_path,'api/datasets'])
        print('mf_path:',self.mf_path)
        self.api_key = api_key
        self.static_payload = {'apikey':self.api_key}

        # training data
        self.training_features = None
        # store metafeatures of datasets that have been seen
        # self.dataset_metafeatures = None
        # maintain a set of dataset-algorithm-parameter combinations that have already been 
        # evaluated
        self.trained_dataset_models = set()
        # TODO: add option for ML estimator
        self.first_update = True

	# load ML Parameter combinations and fit an encoding to them that can be used for
	# learning a model : score = f(ml,p,dataset,metafeatures)
        
        if ml_p is None:
            # pull algorithm/parameter combinations from the server. 
            self.ml_p = get_all_ml_p_from_db('/'.join([db_path,'api/preferences']),api_key)
        else:
            self.ml_p = ml_p

        print('ml_p:',self.ml_p)
        
        self.ml_p = self.params_to_features(self.ml_p)

        # Encoding the variables
        self.LE = defaultdict(LabelEncoder)
        self.OHE = OneHotEncoder(sparse=False)
        
        self.ml_p = self.ml_p.apply(lambda x: self.LE[x.name].fit_transform(x))
        print('ml_p after LE:',self.ml_p)
        self.X_ml_p = self.OHE.fit_transform(self.ml_p.values)
        # self.ml_p = self.ml_p.apply(lambda x: self.OHE[x.name].fit_transform(x))
        print('X after OHE:',self.X_ml_p.shape)

        # Inverse the encoded
        # fit.apply(lambda x: self.LE[x.name].inverse_transform(x))

        # Using the dictionary to label future data
        # self.ml_p.apply(lambda x: self.LE[x.name].transform(x))

        # our ML
        self.ml = XGBClassifier()

    def params_to_features(self, df):
        """convert parameter dictionaries to dataframe columns"""
        param = df['parameters'].apply(eval)
        param = pd.DataFrame.from_records(param)
        param = param.applymap(str)
        print('param:',param)
        df.drop('parameters',inplace=True,axis=1)
        df = pd.concat([df, param],axis=1)
        df.sort_index(axis=1, inplace=True)
        print('df:',df)

        return df

    def update(self, results_data):
        """Update ML / Parameter recommendations based on overall performance in results_data.

        Updates self.scores

        Parameters
        ----------
        results_data: DataFrame with columns corresponding to:
                'dataset'
                'algorithm'
                'parameters'
                self.metric
        """
        # keep track of unique dataset / parameter / classifier combos in results_data
        dap = (results_data['dataset'].values + '|' +
               results_data['algorithm'].values + '|' +
               results_data['parameters'].values)
        d_ml_p = np.unique(dap)
        self.trained_dataset_models.update(d_ml_p)

        # transform data for learning a model from it 
        self.setup_training_data(results_data) 

        # update internal model
        self.update_model()

    def get_metafeatures(self, d):
        """Fetches dataset metafeatures, returning dataframe."""
        print('fetching data for', d)
        payload={}
        # payload = {'metafeatures'}
        payload.update(self.static_payload)
        params = json.dumps(payload).encode('utf8')
        print('full path:', self.mf_path+'/'+d)
        try:
            req = urllib.request.Request(self.mf_path+'/'+d, data=params)
            r = urllib.request.urlopen(req)
            
            data = json.loads(r.read().decode(r.info().get_param('charset')
                                      or 'utf-8'))[0]
        except e:
            print('exception when grabbing metafeature data for',d)
            raise e
        
        mf = [data['metafeatures']]
        # print('mf:',mf)
        df = pd.DataFrame.from_records(mf,columns=mf[0].keys())
        # print('df:',df)
        df['dataset'] = data['_id']
        df.sort_index(axis=1, inplace=True)

        return df

    def transform_ml_p(self,df_ml_p):
        """Encodes categorical labels and transforms them using a one hot encoding."""
        df_ml_p = self.params_to_features(df_ml_p)
        df_ml_p = df_ml_p.apply(lambda x: self.LE[x.name].transform(x))
        print('df_ml_p after LE transform:',df_ml_p)
        X_ml_p = self.OHE.transform(df_ml_p)
        print('df_ml_p after OHE (',X_ml_p.shape,':\n',X_ml_p)
        return X_ml_p

    def setup_training_data(self,results_data):
        """Transforms metafeatures and results data into learnable format."""
        dataset_metafeatures = []
        for d in results_data['dataset'].unique():
            # fetch metafeatures from server for dataset and append
            df = self.get_metafeatures(d)        
            # print('metafeatures:',df)
            dataset_metafeatures.append(df)
            
        df_mf = pd.concat(dataset_metafeatures,ignore_index=True)

        # join df_mf to results_data to get mf rows for each result
        results_mf = pd.merge(results_data, df_mf, on='dataset', how='outer')
        df_mf = results_mf.loc[:,results_mf.columns.isin(df_mf.columns)]
        df_mf.drop('dataset',axis=1,inplace=True)
        print('df_mf:',df_mf)
        # print('dataset_metafeatures:',dataset_metafeatures)
        # transform algorithms and parameters to one hot encoding 
        df_ml_p = results_data.loc[:, results_data.columns.isin(['algorithm','parameters'])]
        X_ml_p = self.transform_ml_p(df_ml_p)
        print('df_ml_p shape:',df_ml_p.shape)
        # join algorithm/parameters with dataset metafeatures
        print('df_mf shape:',df_mf.shape) 
        self.training_features = np.hstack((X_ml_p,df_mf.values))
        
         
        # print('training data:',self.training_features)
        print('training columns:',self.training_features[:10])
        # transform data using label encoder and one hot encoder
        self.training_y = results_data['accuracy'].values
        assert(len(self.training_y)==len(self.training_features))
         
    def recommend(self, dataset_id=None, n_recs=1):
        """Return a model and parameter values expected to do best on dataset.

        Parameters
        ----------
        dataset_id: string
            ID of the dataset for which the recommender is generating recommendations.
        n_recs: int (default: 1), optional
            Return a list of length n_recs in order of estimators and parameters expected to do best.
        """
        # TODO: predict scores over many variations of ML+P and pick the best
        # return ML+P for best average y
        try:
            rec = self.best_model_prediction(dataset_id, n_recs)
            # if a dataset is specified, do not make recommendations for
            # algorithm-parameter combos that have already been run
            if dataset_id is not None:
                rec = [r for r in rec if dataset_id + '|' + r not in
                       self.trained_dataset_models]

            ml_rec = [r.split('|')[0] for r in rec]
            p_rec = [r.split('|')[1] for r in rec]
            rec_score = [self.scores[r] for r in rec]
        except AttributeError:
            print('rec:', rec)
            print('self.scores:', self.scores)
            print('self.w:', self.w)
            raise AttributeError

        # update the recommender's memory with the new algorithm-parameter combos that it recommended
        ml_rec = ml_rec[:n_recs]
        p_rec = p_rec[:n_recs]
        rec_score = rec_score[:n_recs]

        if dataset_id is not None:
            self.trained_dataset_models.update(
                                        ['|'.join([dataset_id, ml, p])
                                        for ml, p in zip(ml_rec, p_rec)])

        return ml_rec, p_rec, rec_score

    def update_model(self):
        """Trains model on datasets and metafeatures."""
        print('updating model')
        current_model = None if self.ml._Booster is None else self.ml.get_booster()
        self.ml.fit(self.training_features, self.training_y, xgb_model = current_model)
        print('model updated')

    def best_model_prediction(self,dataset_id, n_recs=1):
        """Predict scores over many variations of ML+P and pick the best"""
        # get dataset metafeatures
        df_mf = self.get_metafeatures(dataset_id)
        mf = df_mf.drop('dataset',axis=1).values.flatten()
        X_ml_p = self.X_ml_p[np.random.randint(len(self.X_ml_p),size=100)]
        # print('X_ml_p:',self.X_ml_p,self.X_ml_p.shape)
        print('X_ml_p:',X_ml_p,X_ml_p.shape)
        print('mf:',mf,mf.shape)
        # make prediction data consisting of ml + p combinations with metafeatures
        # predict_features = np.array([np.hstack((ml_p, mf)) for ml_p in self.X_ml_p])
        predict_features = np.array([np.hstack((ml_p, mf)) for ml_p in X_ml_p])
        print('predict_features:',predict_features.shape)
        # for p in predict_features:
        #     print(p)

        predict_scores = self.ml.predict(predict_features)
        print('predict scores:',predict_scores,predict_scores.shape)
        predict_idx = np.argsort(predict_scores)[:n_recs]
        predict_ml_p = X_ml_p[predict_idx]
        out = predict_ml_p
        n_samples = len(X_ml_p)
        n_features = X_ml_p.shape[1]
        recovered_X = np.array(
                      [self.OHE.active_features_[col] for col in out.sorted_indices().indices]
                      ).reshape(n_samples, n_features) - self.OHE.feature_indices_[:-1]
        print('recovered_X:',recovered_X)
        predict_ml_p = predict_ml_p.dot(self.OHE.active_features_).astype(int) 
        print('predict_ml_p before LE:',predict_ml_p)
        df_pr_ml_p = pd.DataFrame(data=predict_ml_p,columns = self.ml_p.columns)
        df_pr_ml_p.apply(lambda x: self.LE[x.name].inverse_transform(x))
        predict_ml_p = df_pr_ml_p.values
        print('predict_ml_p:',predict_ml_p)
        return predict_ml_p['algorithm'] + '|' + predict_ml_p['parameters']
        
