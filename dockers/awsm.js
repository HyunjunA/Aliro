var AWS = require('aws-sdk');
AWS.config.update({
    region: 'us-east-2'
});

//launching containers and clusters
var ecs = new AWS.ECS({
    apiVersion: '2014-11-13'
});
//launching instances that belong to clusters
var ec2 = new AWS.EC2();

//making stacks - not sure we need this
cloudformation = new AWS.CloudFormation();


exports.makeStack = function(name, size, callback) {
    var params = p;
    params['StackName'] = name;

    params['Parameters'].push({
        "ParameterValue": name,
        "ParameterKey": "EcsClusterName"
    });
    params['Parameters'].push({
        "ParameterValue": size.toString(),
        "ParameterKey": "AsgMaxSize"
    });
    cloudformation.createStack(params, function(err, data) {
        if (err) {
            console.log(err, err.stack); // an error occurred
            callback(false);
        } else callback(data); // successful response
    });
}

exports.rmStack = function(name, callback) {
    var params = {}
    params['StackName'] = name;
    cloudformation.deleteStack(params, function(err, data) {
        if (err) {
            console.log(err, err.stack); // an error occurred
            callback(false);
        } else callback(data); // successful response
    });
}

exports.grokStack = function(name, callback) {
    var params = {}
    params['StackName'] = name;
    cloudformation.describeStacks(params, function(err, data) {
        if (err) {
            console.log(err, err.stack); // an error occurred
            callback(false);
        } else callback(data); // successful response
    });
}

// make the Instances required to support a forum
var makeInstances = function(forum) {
    var params = {
        MaxCount: 2,
        MinCount: 2,
        ImageId: 'ami-7f735a1a',
        InstanceType: 't2.medium',
        IamInstanceProfile: {
            Name: "ecsInstanceRole"
        },
        SecurityGroups: [
            'ssh', 'backend'
        ],
        TagSpecifications: [{
            ResourceType: 'instance',
            Tags: [{
                Key: 'forum',
                Value: forum
            }, {
                Key: 'Name',
                Value: 'i' + forum
            }]
        }, ],
        //set default cluster for fourum
        UserData: new Buffer("#!/bin/bash\necho ECS_CLUSTER=c" + forum + " >> /etc/ecs/ecs.config\n").toString('base64')
    };
    ec2.runInstances(params, function(err, data) {
        if (err) console.log(err, err.stack); // an error occurred
        else console.log(data); // successful response
    });
}


//shut down the cluster
var destroyCluster = function(forum) {
    var params = {
        cluster: 'c' + forum,
    };
    ecs.deleteCluster(params, function(err, data) {
        if (err) console.log(err, err.stack); // an error occurred
        else console.log(data); // successful response
    });


}

//
var makeCluster = function(forum) {
    var params = {
        clusterName: 'c' + forum,
    };
    ecs.createCluster(params, function(err, data) {
        if (err) console.log(err, err.stack); // an error occurred
        else console.log(data); // successful response
    });
}




//
exports.handleClusters = function(forum, callback) {
    var params = {
        clusters: ['c' + forum]
    };
    ecs.describeClusters(params, function(err, data) {
        if (err) {
            console.log(err, err.stack); // an error occurred
            callback(false);
        } else {
            data['forum'] = forum;
            callback(data);
        }
    });
};
/*

        var params = {
            //    cluster: forum
        };
        ecs.listContainerInstances(params, function(err, data) {
            if (err) console.log(err, err.stack); // an error occurred
            else {
                console.log(data); // successful response
            }
        });
 */


//
var startTask = function(forum, taskDefinition) {
    var params = {
        cluster: 'c' + forum,
        taskDefinition: taskDefinition
    };
    ecs.runTask(params, function(err, data) {
        if (err) {
            console.log(err, err.stack); // an error occurred
            // callback(false);
        } else {
            data['forum'] = forum;
            console.log(data);
            //         callback(data);
        }
    });


}
