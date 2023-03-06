/* ~This file is part of the Aliro library~

Copyright (C) 2023 Epistasis Lab, 
Center for Artificial Intelligence Research and Education (CAIRE),
Department of Computational Biomedicine (CBM),
Cedars-Sinai Medical Center.

Aliro is maintained by:
    - Hyunjun Choi (hyunjun.choi@cshs.org)
    - Miguel Hernandez (miguel.e.hernandez@cshs.org)
    - Nick Matsumoto (nicholas.matsumoto@cshs.org)
    - Jay Moran (jay.moran@cshs.org)
    - and many other generous open source contributors

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

(Autogenerated header, do not modify)

*/
import React, { Component } from 'react';
import { connect } from 'react-redux';
import * as actions from 'data/experiments/selected/actions';
import SceneHeader from '../SceneHeader';
import FetchError from '../FetchError';
import AlgorithmDetails from './components/AlgorithmDetails';
import RunDetails from './components/RunDetails'
import MSEMAEDetails from './components/MSEMAEDetails';;
import ConfusionMatrix from './components/ConfusionMatrix';
import ConfusionMatrixJSON from './components/ConfusionMatrixJSON';
import ROCCurve from './components/ROCCurve';
import ShapSummaryCurve from './components/ShapSummaryCurve';
import ImportanceScore from './components/ImportanceScore';
import ImportanceScoreJSON from './components/ImportanceScoreJSON';
import LearningCurve from './components/LearningCurve';
import LearningCurveJSON from './components/LearningCurveJSON';
import TestChart from './components/TestChart';
import PCA from './components/PCA';
import PCAJSON from './components/PCAJSON';
import TSNE from './components/TSNE';
import TSNEJSON from './components/TSNEJSON';
import RegFigure from './components/RegFigure';
import Score from './components/Score';
import NoScore from './components/NoScore';
import { Header, Grid, Loader, Dropdown, Menu} from 'semantic-ui-react';
import { formatDataset } from 'utils/formatter';
import ClassRate from './components/ClassRate';
import ChatGPT from '../ChatGPT';

class Results extends Component {
  constructor(props) {
    super(props);
    this.getGaugeArray = this.getGaugeArray.bind(this);
  }

  componentDidMount() {
    this.props.fetchExperiment(this.props.params.id);
  }

  componentWillUnmount() {
    this.props.clearExperiment();
  }

  /**
  * Basic helped method to create array containing [key,val] entries where
  *   key - name of given score
  *   value - actual score
  * passed to Score component which uses javascript library C3 to create graphic
  */

  // async getData(filename){
  //   const res = await fetch(filename);
  //   const data = await res.json();
  //   return this.setState({data});
  // }

  getGaugeArray(keyList) {
    const { experiment } = this.props;
    let testList = [];
    let expScores = experiment.data.scores;

    // console.log("experiment.data")
    console.log("experiment.data",experiment.data)
    // console.log(experiment.data['class_1'][0])
    // console.log(experiment.data['class_-1'][0])

    if(typeof(expScores) === 'object'){
      keyList.forEach(scoreKey => {
        if(expScores[scoreKey] && typeof expScores[scoreKey].toFixed === 'function'){
          let tempLabel;
          scoreKey.includes('train')
            ? tempLabel = 'Train (' + expScores[scoreKey].toFixed(2) + ')'
            : tempLabel = 'Test (' + expScores[scoreKey].toFixed(2) + ')';
          testList.push(
            [tempLabel, expScores[scoreKey]]
          );
        }
      });     
    }

    return testList;
  }

  render() {
    const { experiment, fetchExperiment } = this.props;

    if(experiment.isFetching || !experiment.data) {
      return (
        <Loader active inverted size="large" content="Retrieving results..." />
      );
    }

    if(experiment.error === 'Failed to fetch') {
      return (
        <FetchError
          message="The specified experiment does not exist."
        />
      );
    } else if(experiment.error) {
      return (
        <FetchError
          message={experiment.error}
          onRetry={() => fetchExperiment()}
        />
      );
    }

    const downloadModel = (id) => {
      fetch(`/api/v1/experiments/${id}/model`)
        .then(response => {
          if(response.status >= 400) {
            throw new Error(`${response.status}: ${response.statusText}`);
          }
          return response.json();
        })
        .then(json => {
          window.location = `/api/v1/files/${json._id}`;
        });
    };

    const downloadScript = (id) => {
      fetch(`/api/v1/experiments/${id}/script`)
        .then(response => {
          if(response.status >= 400) {
            throw new Error(`${response.status}: ${response.statusText}`);
          }
          return response.json();
        })
        .then(json => {
          window.location = `/api/v1/files/${json._id}`;
        });
    };

    // console.log(experiment.data.prediction_type)
    // --- get lists of scores ---
    if(experiment.data.prediction_type == "classification") { // classification

      console.log("experiment.data", experiment.data)
      // console.log("X_pca", experiment.data.X_pca)
      // console.log("y_pca", experiment.data.y_pca)

      let confusionMatrix, rocCurve, importanceScore, learningCurve, pca, pca_json, tsne, tsne_json, shap_explainer, shap_num_samples;
      
      let shapSummaryCurveDict = {};

          
      experiment.data.experiment_files.forEach(file => {
        const filename = file.filename;
        console.log('filename',filename);
        if(filename.includes('confusion_matrix')) {
          confusionMatrix = file;
        } else if(filename.includes('roc_curve')) {
          rocCurve = file;
          // save to local storage
          localStorage.setItem('rocCurve',rocCurve);
        } else if(filename.includes('imp_score')) {
          importanceScore = file;
        } else if(filename.includes('learning_curve')) {
          learningCurve = file;
          
          
        } else if(filename.includes('pca') && filename.includes('png')) {
          pca = file;
          console.log("pca", pca)
        } else if (filename.includes('pca-json')) {
          console.log("pca_json")
          pca_json = file;
          console.log("pca_json: ", pca_json)
        }

        else if(filename.includes('tsne') && filename.includes('png')) {
          tsne = file;
          console.log("tsne", tsne)

        }
        else if (filename.includes('tsne-json')) {
          console.log("tsne_json")
          tsne_json = file;
          console.log("tsne_json: ", tsne_json)
        } 
        
        else if(filename.includes('shap_summary_curve')) {
          console.log("shap_summary_curve")
          let class_name = filename.split('_').slice(-2,-1);
          shapSummaryCurveDict[class_name] = file;
          shap_explainer=experiment.data.shap_explainer;
          shap_num_samples=experiment.data.shap_num_samples;

          // save to local storage
          localStorage.setItem('shapSummaryCurveDict',JSON.stringify(shapSummaryCurveDict));
          localStorage.setItem('shap_explainer',shap_explainer);
          localStorage.setItem('shap_num_samples',shap_num_samples);



        }
        else if (filename.includes('shap_summary_json')) {
          console.log("shap_summary_json")
          // shap_json = file;
          // console.log("shap_json: ", shap_json)
        }
        
      });
      // balanced accuracy
      let balancedAccKeys = ['train_balanced_accuracy_score', 'balanced_accuracy_score'];
      // precision scores
      let precisionKeys = ['train_precision_score', 'precision_score']
      // AUC
      let aucKeys = ['train_roc_auc_score', 'roc_auc_score'];
      // f1 score
      let f1Keys = ['train_f1_score', 'f1_score'];
      // recall
      let recallKeys = ['train_recall_score', 'recall_score'];

      let balancedAccList = this.getGaugeArray(balancedAccKeys);
      let precisionList = this.getGaugeArray(precisionKeys);
      let aucList = this.getGaugeArray(aucKeys);
      let recallList = this.getGaugeArray(recallKeys);
      let f1List = this.getGaugeArray(f1Keys);
      let class_percentage = [];
      // let pca_data = [];

      
      
      
      experiment.data.class_names.forEach(eachclass => {

        console.log('eachclass.toString()', eachclass.toString())
        // if type of experiment.data['class_' +  eachclass.toString()] === 'object'
        if ((typeof experiment.data['class_' +  eachclass.toString()]) === 'object')
        {
          class_percentage.push(
            [eachclass.toString(), experiment.data['class_' +  eachclass.toString()][0]]
          );
          console.log("experiment.data['class_1']", experiment.data['class_1'])
        }
        else
        {
          class_percentage.push(
            [eachclass.toString(), experiment.data['class_' +  eachclass.toString()]]
        );
        console.log("experiment.data['class_1']", experiment.data['class_1'])
        }


        
      });




      console.log('balancedAccList',balancedAccList)
      // save to local storage
      localStorage.setItem('balancedAccList', JSON.stringify(balancedAccList));
      
      console.log('precisionList',precisionList)
      // save to local storage
      localStorage.setItem('precisionList', JSON.stringify(precisionList));
      
      // save to local storage
      console.log('aucList',aucList)
      localStorage.setItem('aucList', JSON.stringify(aucList));

      // save to local storage
      console.log('recallList',recallList)
      localStorage.setItem('recallList', JSON.stringify(recallList));

      // save to local storage
      console.log('f1List',f1List)
      localStorage.setItem('f1List', JSON.stringify(f1List));

      // save to local storage
      console.log('class_percentage',class_percentage)
      localStorage.setItem('class_percentage', JSON.stringify(class_percentage));




      return (
        
        
        <div>

          

          {/* GPT Space */}
          {/* <Grid columns={4} stackable="stackable">
              <ChatGPT/>
          </Grid> */}


          {/* GPT Space */}
          <ChatGPT experiment={experiment}/>



        </div>

        

      );
    } else if(experiment.data.prediction_type == "regression") { // regression
      let importanceScore, reg_cv_pred, reg_cv_resi, reg_cv_qq;
      experiment.data.experiment_files.forEach(file => {
        const filename = file.filename;
        if(filename.includes('imp_score')) {
          importanceScore = file;
        } else if(filename.includes('reg_cv_pred')) {
          reg_cv_pred = file;
        } else if(filename.includes('reg_cv_resi')) {
          reg_cv_resi = file;
        } else if(filename.includes('reg_cv_qq')) {
          reg_cv_qq = file;
        }

      });
      // r2
      let R2Keys = ['train_r2_score', 'r2_score'];
      // r
      let RKeys = ['train_pearsonr_score', 'pearsonr_score'];
      // r2
      let VAFKeys = ['train_explained_variance_score', 'explained_variance_score'];

      let R2List = this.getGaugeArray(R2Keys);
      let RList = this.getGaugeArray(RKeys);
      let VAFList = this.getGaugeArray(VAFKeys);


      return (
        <div>
          <Grid columns={2} stackable>
            <Grid.Row>
              <Grid.Column>
                <SceneHeader
                  header={`Results: ${formatDataset(experiment.data.dataset_name)}`}
                  subheader={`Experiment: #${experiment.data._id}`}
                />
              </Grid.Column>
              <Grid.Column>
                <Menu compact inverted floated='right' color='grey'>
                  <Dropdown
                    text='Download'
                    simple item
                    disabled={['cancelled', 'fail'].includes(experiment.data.status)}
                  >
                    <Dropdown.Menu>
                        <Dropdown.Item
                          key="model"
                          icon="download"
                          text="Model"
                          onClick={() => downloadModel(experiment.data._id)}
                        />,
                        <Dropdown.Item
                          key="script"
                          icon="download"
                          text="Script"
                          onClick={() => downloadScript(experiment.data._id)}
                        />
                    </Dropdown.Menu>
                  </Dropdown>
                </Menu>
              </Grid.Column>
            </Grid.Row>
          </Grid>
          <Grid columns={3} stackable>
            <Grid.Row>
              <Grid.Column>


                <AlgorithmDetails
                  algorithm={experiment.data.algorithm}
                  params={experiment.data.params}
                />
                <RunDetails
                  startTime={experiment.data.started}
                  finishTime={experiment.data.finished}
                  launchedBy={experiment.data.launched_by}
                />
                {/* <ImportanceScore file={importanceScore} /> */}
                <ImportanceScoreJSON
                  scoreName="Feature Importance"
                  scoreValueList={experiment.data.feature_importances}
                  featureList={experiment.data.feature_names}
                  chartKey="importance_score"
                  chartColor="#55D6BE"
                  type="regression"
                />

              </Grid.Column>
              <Grid.Column>
                {/* <RegFigure file={reg_cv_pred} /> */}
                {/* <RegFigure file={reg_cv_resi} /> */}
                {/* <RegFigure file={reg_cv_qq} /> */}

                <PCAJSON scoreName="Cross-Validated Predictions"
                  Points={experiment.data.CVP_2d}
                  Labels={experiment.data.CVP_2d_class}
                  chartKey="CVP"
                  chartColor="#55D6BE"
                  type="classification"
                />

                <PCAJSON scoreName="Cross-Validated Residuals"
                  Points={experiment.data.CVR_2d}
                  Labels={experiment.data.CVR_2d_class}
                  chartKey="CVR"
                  chartColor="#55D6BE"
                  type="classification"
                />


                <PCAJSON scoreName="Q-Q Plot for Normalized Residuals"
                  Points={experiment.data.QQNR_2d}
                  Labels={experiment.data.QQNR_2d_class}
                  chartKey="QQNR"
                  chartColor="#55D6BE"
                  type="classification"
                />




              </Grid.Column>
              <Grid.Column>
                <MSEMAEDetails
                  scores={experiment.data.scores}
                />
                <Score
                  scoreName="Coefficient of Determination"
                  scoreValueList={R2List}
                  chartKey="R2"
                  chartColor="#55D6BE"
                  type="r2_or_vaf"
                />
                <Score
                  scoreName="Explained Variance"
                  scoreValueList={VAFList}
                  chartKey="VAF"
                  chartColor="#55D6BE"
                  type="r2_or_vaf"
                />
                <Score
                  scoreName="Pearson's r"
                  scoreValueList={RList}
                  chartKey="pearsonr"
                  chartColor="#55D6BE"
                  type="pearsonr"
                />

              </Grid.Column>
            </Grid.Row>
          </Grid>

          {/* GPT Space */}
          {/* <Grid columns={4} stackable="stackable">
              <ChatGPT/>
          </Grid> */}
          
          {/* GPT Space */}
          <ChatGPT experiment={experiment}/>
          

        </div>
      );
    }
  }
}

const mapStateToProps = (state) => ({
  experiment: state.experiments.selected
});

export { Results };
export default connect(mapStateToProps, actions)(Results);
