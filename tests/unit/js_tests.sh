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

# echo "Installing necessary packages..."
# npm install --no-save @babel/core @babel/node @babel/preset-env @babel/preset-react

# Install Enzyme and React 16 adapter
# npm install --save-dev enzyme enzyme-adapter-react-16

# Install Jest

# # Uninstall current Jest version
# npm uninstall jest

# # Install Jest version 26.6.3 (a stable version that's not too old)
# npm install --save-dev jest@26.6.3

# # Install related packages at compatible versions
# npm install --save-dev @types/jest@26.0.24
# npm install --save-dev babel-jest@26.6.3
# npm install --save-dev ts-jest@26.5.6

# # If you're using enzyme, install a compatible version
# npm install --save-dev enzyme@3.11.0
# npm install --save-dev enzyme-adapter-react-16@1.15.6

# # Update package.json to use the installed Jest version
# npm pkg set scripts.test="jest"

# # Optional: Clear npm cache and node_modules
# # Uncomment these lines if you're still having issues
# # npm cache clean --force
# # rm -rf node_modules
# # npm install

# echo "Jest 26.6.3 and compatible packages have been installed."

# # Check Jest version
# echo "Installed Jest version:"
# npx jest --version



echo "starting '/lab' jest reports"
cd "/appsrc/lab/"
npm run test
labres=$?
echo "==== labres unit tests result "$labres

echo "starting '/lab/webapp' jest reports"
cd "/appsrc/lab/webapp/"
npm run test
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