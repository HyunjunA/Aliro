# #!/bin/bash

# # unit test runner for jest javascript tests

# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH}"

# echo "starting '/lab' jest reports"
# cd "/appsrc/lab/"
# npm run test
# labres=$?
# echo "==== labres unit tests result "$labres

# echo "starting '/lab/webapp' jest reports"
# cd "/appsrc/lab/webapp/"
# npm run test
# webappres=$?
# echo "==== webappres unit tests result "$webappres

# cd "/appsrc"

# # exit with error code 1 if either test fails
# if [ $labres -eq 0 -a $webappres -eq 0 ]; then exit 0; else exit 1; fi






#!/bin/bash

# # Install Node.js 14
# echo "Installing Node.js 14..."
# curl -sL https://deb.nodesource.com/setup_18.x | bash -
# apt-get install -y nodejs

# Print Node.js version
echo "Node.js version:"
node -v

# Print npm version
echo "npm version:"
npm -v

# Print Jest version
echo "Jest version:"
npx jest --version

# unit test runner for jest javascript tests

export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH}"

echo "JEST_JUNIT_OUTPUT_DIR" $JEST_JUNIT_OUTPUT_DIR

# Set Node.js options
export NODE_OPTIONS="--experimental-modules --no-warnings"

# Function to find node:stream module
find_node_modules() {
    echo "Searching for node:stream and node:assert modules..."
    node -e "
    const path = require('path');
    const modules = ['stream', 'assert'];
    
    modules.forEach(moduleName => {
        try {
            const modulePath = require.resolve(moduleName);
            const absolutePath = path.resolve(modulePath);
            console.log('node:' + moduleName + ' module found at: ' + absolutePath);
        } catch(e) {
            console.error('node:' + moduleName + ' module not found');
        }
    });

    // 추가적으로 Node.js의 내장 모듈 경로 출력
    console.log('Node.js built-in modules directory:', path.dirname(process.execPath) + '/lib');
    "
}

# 함수 실행
find_node_modules


echo "starting '/lab' jest reports"
cd "/appsrc/lab/"
npm run test
labres=$?
echo "==== labres unit tests result "$labres

echo "starting '/lab/webapp' jest reports"
cd "/appsrc/lab/webapp/"
npm run test
# npm test -- -u
webappres=$?
echo "==== webappres unit tests result "$webappres

cd "/appsrc"

# exit with error code 1 if either test fails
if [ $labres -eq 0 -a $webappres -eq 0 ]; then exit 0; else exit 1; fi

# exit with error code 1 if either test fails
if [ $labres -eq 0 -a $webappres -eq 0 ]; then 
    echo "All tests passed successfully."
    exit 0
else 
    echo "Some tests failed. Please check the output above for details."
    exit 1
fi