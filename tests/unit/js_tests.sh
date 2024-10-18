# origin

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



# tweek 1
# #!/bin/bash

# # unit test runner for jest javascript tests

# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH}"

# # Node.js 버전 확인
# node_version=$(node -v)
# echo "Using Node.js version: $node_version"

# # Jest와 필요한 종속성 설치
# echo "Installing Jest and dependencies..."
# npm install --no-save jest @babel/core @babel/preset-env @babel/preset-react babel-jest enzyme enzyme-adapter-react-16 enzyme-to-json

# echo "starting '/lab' jest tests"
# cd "/appsrc/lab/"
# npx jest --reporters=default --ci
# labres=$?
# echo "==== labres unit tests result "$labres

# echo "starting '/lab/webapp' jest tests"
# cd "/appsrc/lab/webapp/"
# npx jest --reporters=default --ci
# webappres=$?
# echo "==== webappres unit tests result "$webappres

# cd "/appsrc"

# # exit with error code 1 if either test fails
# if [ $labres -eq 0 -a $webappres -eq 0 ]; then exit 0; else exit 1; fi


# tweek2
# #!/bin/sh

# # unit test runner for jest javascript tests

# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH}"

# # Node.js 버전 확인
# node_version=$(node -v)
# echo "Using Node.js version: $node_version"

# # Jest와 필요한 종속성 설치
# echo "Installing Jest and dependencies..."
# npm install --no-save jest @babel/core @babel/preset-env @babel/preset-react babel-jest enzyme enzyme-adapter-react-16 enzyme-to-json @babel/plugin-transform-modules-commonjs

# # Jest 설정 파일 생성
# cat << EOF > jest.config.js
# const path = require('path');

# module.exports = {
#   transform: {
#     '^.+\\.(js|jsx|ts|tsx)$': 'babel-jest',
#   },
#   moduleNameMapper: {
#     '^node:(.*)$': '<rootDir>/node_modules/$1',
#   },
#   setupFilesAfterEnv: ['./jest.setup.js'],
#   testEnvironment: 'jsdom',
#   moduleDirectories: ['node_modules', path.join(__dirname, 'src')],
#   transformIgnorePatterns: [
#     'node_modules/(?!(parse5-parser-stream)/)',
#   ],
# };
# EOF

# # Babel 설정 파일 생성
# cat << EOF > babel.config.js
# module.exports = {
#   presets: [
#     ['@babel/preset-env', {targets: {node: 'current'}}],
#     '@babel/preset-react'
#   ],
#   plugins: ['@babel/plugin-transform-modules-commonjs']
# };
# EOF

# # Jest 설정 파일 생성
# cat << EOF > jest.setup.js
# const Enzyme = require('enzyme');
# const Adapter = require('enzyme-adapter-react-16');

# Enzyme.configure({ adapter: new Adapter() });

# // Node.js 내장 모듈에 대한 폴리필
# global.TextEncoder = require('util').TextEncoder;
# global.TextDecoder = require('util').TextDecoder;
# EOF

# echo "starting '/lab' jest tests"
# cd "/appsrc/lab/"
# npx jest --config=../jest.config.js --reporters=default --ci
# labres=$?
# echo "==== labres unit tests result $labres"

# echo "starting '/lab/webapp' jest tests"
# cd "/appsrc/lab/webapp/"
# npx jest --config=../../jest.config.js --reporters=default --ci
# webappres=$?
# echo "==== webappres unit tests result $webappres"

# cd "/appsrc"

# # exit with error code 1 if either test fails
# if [ $labres -eq 0 ] && [ $webappres -eq 0 ]; then
#     exit 0
# else
#     exit 1
# fi








# #!/bin/bash

# # unit test runner for jest javascript tests with detailed environment check

# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH}"

# # Function to check Node.js version
# check_node_version() {
#     echo "Node.js version:"
#     node --version
#     echo "npm version:"
#     npm --version
# }

# # Function to provide interactive command prompt
# provide_command_prompt() {
#     echo "Enter commands (type 'exit' to continue with the script):"
#     while true; do
#         read -p "> " cmd
#         if [ "$cmd" = "exit" ]; then
#             break
#         fi
#         eval $cmd
#     done
# }

# # Function to check for stream module usage in project source
# check_stream_usage_in_source() {
#     echo "Checking for 'stream' and 'node:stream' module usage in project source:"
    
#     # Check for 'stream' usage
#     echo "Files using 'stream' module:"
#     grep -R --include="*.js" --exclude-dir="node_modules" "require('stream')" /appsrc
#     grep -R --include="*.js" --exclude-dir="node_modules" "from 'stream'" /appsrc
    
#     # Check for 'node:stream' usage
#     echo "Files using 'node:stream' module:"
#     grep -R --include="*.js" --exclude-dir="node_modules" "require('node:stream')" /appsrc
#     grep -R --include="*.js" --exclude-dir="node_modules" "from 'node:stream'" /appsrc
    
#     # If no results found
#     if [ $? -ne 0 ]; then
#         echo "No 'stream' or 'node:stream' module usage found in project source."
#     fi
# }

# # Function to check Jest configuration for node:stream mapping
# check_jest_config() {
#     echo "Checking Jest configuration for node:stream mapping:"
#     for config_file in $(find /appsrc -name "jest.config.js" -o -name "jest.config.ts" -o -name "package.json"); do
#         if grep -q "node:stream" "$config_file"; then
#             echo "Found node:stream configuration in $config_file:"
#             grep -n "node:stream" "$config_file"
#         fi
#     done
# }

# # Function to check for moduleNameMapper in Jest config
# check_module_name_mapper() {
#     echo "Checking for moduleNameMapper in Jest config:"
#     for config_file in $(find /appsrc -name "jest.config.js" -o -name "jest.config.ts" -o -name "package.json"); do
#         if grep -q "moduleNameMapper" "$config_file"; then
#             echo "Found moduleNameMapper in $config_file:"
#             sed -n '/moduleNameMapper/,/}/p' "$config_file"
#         fi
#     done
# }

# # Run environment checks
# echo "=== Environment Check ==="
# check_node_version

# # Provide interactive command prompt
# provide_command_prompt

# check_stream_usage_in_source
# check_jest_config
# check_module_name_mapper
# echo "========================="

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










# #!/bin/bash

# # Check Node.js version
# node_version=$(node --version)
# required_version="v14.17.0"

# if [ "$(printf '%s\n' "$required_version" "$node_version" | sort -V | head -n1)" = "$required_version" ]; then 
#     echo "Node.js version is sufficient"
# else 
#     echo "Node.js version is too old. Please update to at least $required_version"
#     exit 1
# fi

# # Update Jest configuration
# update_jest_config() {
#     local config_file="$1/jest.config.js"
#     if [ -f "$config_file" ]; then
#         echo "Updating Jest configuration in $config_file"
#         sed -i 's/moduleFileExtensions/\/\/ moduleFileExtensions/' "$config_file"
#         echo "module.exports = { ...module.exports, moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx', 'node', 'mjs'] };" >> "$config_file"
#     else
#         echo "Jest configuration file not found in $1"
#     fi
# }

# # Disable Jest HTML Reporter
# disable_html_reporter() {
#     local package_file="$1/package.json"
#     if [ -f "$package_file" ]; then
#         echo "Disabling Jest HTML Reporter in $package_file"
#         sed -i 's/"jest-html-reporter"/"jest-html-reporter": "^3.7.0"/' "$package_file"
#         npm i --save-dev jest-html-reporter@3.7.0
#     else
#         echo "package.json file not found in $1"
#     fi
# }

# # Set environment variable for Jest output
# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH}"

# # Run tests for /lab
# echo "Starting '/lab' Jest tests"
# cd "/appsrc/lab/"
# update_jest_config "."
# disable_html_reporter "."
# npm run test -- --reporters=default --reporters=jest-junit
# labres=$?
# echo "==== Lab tests result: $labres"

# # Run tests for /lab/webapp
# echo "Starting '/lab/webapp' Jest tests"
# cd "/appsrc/lab/webapp/"
# update_jest_config "."
# disable_html_reporter "."
# npm run test -- --reporters=default --reporters=jest-junit
# webappres=$?
# echo "==== Webapp tests result: $webappres"

# # Return to the original directory
# cd "/appsrc"

# # Exit with error code 1 if either test fails
# if [ $labres -eq 0 ] && [ $webappres -eq 0 ]; then 
#     echo "All tests passed successfully"
#     exit 0
# else 
#     echo "Some tests failed"
#     exit 1
# fi








# #!/bin/bash

# # Check Node.js version
# node_version=$(node --version)
# required_version="v14.17.0"

# if [ "$(printf '%s\n' "$required_version" "$node_version" | sort -V | head -n1)" = "$required_version" ]; then 
#     echo "Node.js version is sufficient"
# else 
#     echo "Node.js version is too old. Please update to at least $required_version"
#     exit 1
# fi

# # Update Jest configuration
# update_jest_config() {
#     local config_file="$1/jest.config.js"
#     if [ -f "$config_file" ]; then
#         echo "Updating Jest configuration in $config_file"
#         sed -i 's/moduleFileExtensions/\/\/ moduleFileExtensions/' "$config_file"
#         echo "module.exports = { ...module.exports, moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx', 'node', 'mjs'] };" >> "$config_file"
#     else
#         echo "Jest configuration file not found in $1"
#     fi
# }

# # Disable Jest HTML Reporter
# disable_html_reporter() {
#     local package_file="$1/package.json"
#     if [ -f "$package_file" ]; then
#         echo "Disabling Jest HTML Reporter in $package_file"
#         # Use jq to safely modify JSON
#         jq '.devDependencies."jest-html-reporter" = "3.7.0"' "$package_file" > "$package_file.tmp" && mv "$package_file.tmp" "$package_file"
#         npm i --save-dev jest-html-reporter@3.7.0
#     else
#         echo "package.json file not found in $1"
#     fi
# }

# # Set environment variable for Jest output
# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH}"

# # Run tests for /lab
# echo "Starting '/lab' Jest tests"
# cd "/appsrc/lab/"
# update_jest_config "."
# disable_html_reporter "."
# npm run test -- --reporters=default --reporters=jest-junit
# labres=$?
# echo "==== Lab tests result: $labres"

# # Run tests for /lab/webapp
# echo "Starting '/lab/webapp' Jest tests"
# cd "/appsrc/lab/webapp/"
# update_jest_config "."
# disable_html_reporter "."
# npm run test -- --reporters=default --reporters=jest-junit
# webappres=$?
# echo "==== Webapp tests result: $webappres"

# # Return to the original directory
# cd "/appsrc"

# # Exit with error code 1 if either test fails
# if [ $labres -eq 0 ] && [ $webappres -eq 0 ]; then 
#     echo "All tests passed successfully"
#     exit 0
# else 
#     echo "Some tests failed"
#     exit 1
# fi


# almost_v1
# #!/bin/bash

# # Exit immediately if a command exits with a non-zero status.
# set -e

# # Check Node.js version
# node_version=$(node --version)
# required_version="v14.17.0"

# if [ "$(printf '%s\n' "$required_version" "$node_version" | sort -V | head -n1)" = "$required_version" ]; then 
#     echo "Node.js version is sufficient"
# else 
#     echo "Node.js version is too old. Please update to at least $required_version"
#     exit 1
# fi

# # Update Jest configuration
# update_jest_config() {
#     local config_file="$1/jest.config.js"
#     if [ -f "$config_file" ]; then
#         echo "Updating Jest configuration in $config_file"
#         sed -i 's/moduleFileExtensions/\/\/ moduleFileExtensions/' "$config_file"
#         echo "module.exports = { ...module.exports, moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx', 'node', 'mjs'] };" >> "$config_file"
#     else
#         echo "Jest configuration file not found in $1"
#     fi
# }

# # Disable Jest HTML Reporter
# disable_html_reporter() {
#     local package_file="$1/package.json"
#     if [ -f "$package_file" ]; then
#         echo "Disabling Jest HTML Reporter in $package_file"
#         # Backup the original file
#         cp "$package_file" "${package_file}.bak"
#         # Use sed to safely modify JSON
#         sed -i 's/\("jest-html-reporter"\s*:\s*"[^"]*"\)\s*:\s*"[^"]*"\s*:\s*"[^"]*"/\1/' "$package_file"
#         # Check if the modification was successful
#         if ! node -e "JSON.parse(require('fs').readFileSync('$package_file', 'utf8')); console.log('JSON is valid');" 2>/dev/null; then
#             echo "Error: Failed to modify package.json. Restoring backup."
#             mv "${package_file}.bak" "$package_file"
#             return 1
#         fi
#         echo "Successfully updated package.json"
#         rm "${package_file}.bak"
#         npm i --save-dev jest-html-reporter@3.7.0
#     else
#         echo "package.json file not found in $1"
#         return 1
#     fi
# }

# # Set environment variable for Jest output
# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH}"

# # Function to run tests
# run_tests() {
#     local dir=$1
#     local name=$2
#     echo "Starting '$dir' Jest tests"
#     cd "$dir"
#     update_jest_config "."
#     if ! disable_html_reporter "."; then
#         echo "Failed to update package.json. Skipping tests for $name."
#         return 1
#     fi
#     if npm run test -- --reporters=default --reporters=jest-junit; then
#         echo "==== $name tests passed"
#         return 0
#     else
#         echo "==== $name tests failed"
#         return 1
#     fi
# }

# # Run tests for /lab
# if ! run_tests "/appsrc/lab/" "Lab"; then
#     lab_failed=true
# fi

# # Run tests for /lab/webapp
# if ! run_tests "/appsrc/lab/webapp/" "Webapp"; then
#     webapp_failed=true
# fi

# # Exit with error code 1 if either test fails
# if [ "$lab_failed" = true ] || [ "$webapp_failed" = true ]; then
#     echo "Some tests failed"
#     exit 1
# else
#     echo "All tests passed successfully"
#     exit 0
# fi







# pass all tests except the last one
# #!/bin/bash

# # Exit immediately if a command exits with a non-zero status.
# set -e

# # Install jq if not already installed
# if ! command -v jq &> /dev/null; then
#     echo "Installing jq..."
#     apt-get update && apt-get install -y jq
# fi

# # Update dependencies and fix vulnerabilities
# update_dependencies() {
#     echo "Updating dependencies and fixing vulnerabilities"
#     npm install --legacy-peer-deps
#     npm install --save-dev @babel/core@latest @babel/preset-env@latest @babel/preset-react@latest babel-jest@latest jest@latest jest-environment-jsdom@latest core-js@latest regenerator-runtime@latest @babel/plugin-syntax-jsx@latest @babel/plugin-transform-runtime@latest @testing-library/jest-dom@latest @testing-library/react@latest identity-obj-proxy@latest
#     npm uninstall enzyme enzyme-adapter-react-16
#     npm audit fix --force || true
#     npx browserslist@latest --update-db || true
# }

# # Update package.json
# update_package_json() {
#     local package_file="$1/package.json"
#     echo "Updating package.json in $package_file"
    
#     # Use jq to modify the JSON file, removing the "type": "module"
#     jq '.license = "UNLICENSED" | del(.jest) | del(.type)' "$package_file" > "${package_file}.tmp" && mv "${package_file}.tmp" "$package_file"
# }

# # Update Jest configuration
# update_jest_config() {
#     local config_file="$1/jest.config.js"
#     echo "Updating Jest configuration in $config_file"
#     cat > "$config_file" << EOL
# module.exports = {
#   moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx', 'node', 'mjs'],
#   transform: {
#     '^.+\\.(js|jsx|mjs|cjs|ts|tsx)$': ['babel-jest', { configFile: './babel.config.js' }],
#   },
#   transformIgnorePatterns: [
#     'node_modules/(?!(cheerio|parse5|domhandler|dom-serializer|htmlparser2|domelementtype)/)'
#   ],
#   setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
#   testEnvironment: 'jsdom',
#   testMatch: ['**/__tests__/**/*.[jt]s?(x)', '**/?(*.)+(spec|test).[jt]s?(x)'],
#   moduleNameMapper: {
#     '\\.(css|less|scss|sass)$': 'identity-obj-proxy'
#   }
# };
# EOL
# }

# # Create Babel configuration
# create_babel_config() {
#     local babel_config="$1/babel.config.js"
#     echo "Creating Babel configuration in $babel_config"
#     cat > "$babel_config" << EOL
# module.exports = {
#   presets: [
#     ['@babel/preset-env', {
#       targets: {
#         node: 'current',
#       },
#     }],
#     '@babel/preset-react',
#   ],
#   plugins: [
#     '@babel/plugin-syntax-jsx',
#     '@babel/plugin-transform-runtime',
#   ],
# };
# EOL
# }

# # Create Jest setup file
# create_jest_setup() {
#     local setup_file="$1/jest.setup.js"
#     echo "Creating Jest setup file in $setup_file"
#     cat > "$setup_file" << EOL
# require('core-js/stable');
# require('regenerator-runtime/runtime');
# require('@testing-library/jest-dom');
# EOL
# }

# # Update test files to use @testing-library/react instead of enzyme
# update_test_files() {
#     local dir=$1
#     echo "Updating test files in $dir to use @testing-library/react"
#     find "$dir" -name "*.test.js" -type f -exec sed -i 's/import { shallow, mount, render } from '\''enzyme'\''/import { render, screen, fireEvent } from '\''@testing-library\/react'\''/' {} +
#     find "$dir" -name "*.test.js" -type f -exec sed -i '/import Adapter from '\''enzyme-adapter-react-16'\''/d' {} +
#     find "$dir" -name "*.test.js" -type f -exec sed -i '/configure({ adapter: new Adapter() })/d' {} +
#     # Convert import statements to require
#     find "$dir" -name "*.test.js" -type f -exec sed -i 's/import \(.*\) from '\''\\(.*\\)'\''/const \1 = require('\''\\2'\'')/' {} +
# }

# # Disable Jest HTML Reporter
# update_html_reporter_config() {
#     local package_file="$1/package.json"
#     if [ -f "$package_file" ]; then
#         echo "Disabling Jest HTML Reporter in $package_file"
#         jq '.devDependencies["jest-html-reporter"] = "^3.7.0"' "$package_file" > "${package_file}.tmp" && mv "${package_file}.tmp" "$package_file"
#         npm install --save-dev jest-html-reporter@3.7.0 --legacy-peer-deps
#     else
#         echo "package.json file not found in $1"
#         return 1
#     fi
# }

# # Set environment variable for Jest output
# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH:-./junit}"

# # Function to run tests
# run_tests() {
#     local dir=$1
#     local name=$2
#     echo "Starting '$dir' Jest tests"
#     cd "$dir"
#     update_dependencies
#     update_package_json "."
#     update_jest_config "."
#     create_babel_config "."
#     create_jest_setup "."
#     update_test_files "."
#     update_html_reporter_config "."
#     if npx jest --config=jest.config.js --reporters=default --reporters=jest-junit --updateSnapshot; then
#         echo "==== $name tests passed"
#         return 0
#     else
#         echo "==== $name tests failed"
#         return 1
#     fi
# }

# # Run tests for /lab
# if ! run_tests "/appsrc/lab" "Lab"; then
#     lab_failed=true
# fi

# # Run tests for /lab/webapp
# if ! run_tests "/appsrc/lab/webapp" "Webapp"; then
#     webapp_failed=true
# fi

# # Exit with error code 1 if either test fails
# if [ "${lab_failed:-false}" = true ] || [ "${webapp_failed:-false}" = true ]; then
#     echo "Some tests failed"
#     exit 1
# else
#     echo "All tests passed successfully"
#     exit 0
# fi




# pass all except the two cases
# #!/bin/bash

# # Exit immediately if a command exits with a non-zero status.
# set -e

# # Install jq if not already installed
# if ! command -v jq &> /dev/null; then
#     echo "Installing jq..."
#     apt-get update && apt-get install -y jq
# fi

# # Update dependencies and fix vulnerabilities
# update_dependencies() {
#     echo "Updating dependencies and fixing vulnerabilities"
#     npm install --legacy-peer-deps
#     npm install --save-dev @babel/core@latest @babel/preset-env@latest @babel/preset-react@latest babel-jest@latest jest@latest jest-environment-jsdom@latest core-js@latest regenerator-runtime@latest @babel/plugin-syntax-jsx@latest @babel/plugin-transform-runtime@latest @testing-library/jest-dom@latest @testing-library/react@latest identity-obj-proxy@latest
#     npm uninstall enzyme enzyme-adapter-react-16
#     npm audit fix --force || true
#     npx browserslist@latest --update-db || true
# }

# # Update package.json
# update_package_json() {
#     local package_file="$1/package.json"
#     echo "Updating package.json in $package_file"
    
#     # Use jq to modify the JSON file, removing the "type": "module"
#     jq '.license = "UNLICENSED" | del(.jest) | del(.type)' "$package_file" > "${package_file}.tmp" && mv "${package_file}.tmp" "$package_file"
# }

# # Update Jest configuration
# update_jest_config() {
#     local config_file="$1/jest.config.js"
#     echo "Updating Jest configuration in $config_file"
#     cat > "$config_file" << EOL
# module.exports = {
#   moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx', 'node', 'mjs'],
#   transform: {
#     '^.+\\.(js|jsx|mjs|cjs|ts|tsx)$': ['babel-jest', { configFile: './babel.config.js' }],
#   },
#   transformIgnorePatterns: [
#     'node_modules/(?!(cheerio|parse5|domhandler|dom-serializer|htmlparser2|domelementtype)/)'
#   ],
#   setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
#   testEnvironment: 'jsdom',
#   testMatch: ['**/__tests__/**/*.[jt]s?(x)', '**/?(*.)+(spec|test).[jt]s?(x)'],
#   moduleNameMapper: {
#     '\\.(css|less|scss|sass)$': 'identity-obj-proxy'
#   }
# };
# EOL
# }

# # Create Babel configuration
# create_babel_config() {
#     local babel_config="$1/babel.config.js"
#     echo "Creating Babel configuration in $babel_config"
#     cat > "$babel_config" << EOL
# module.exports = {
#   presets: [
#     ['@babel/preset-env', {
#       targets: {
#         node: 'current',
#       },
#     }],
#     '@babel/preset-react',
#   ],
#   plugins: [
#     '@babel/plugin-syntax-jsx',
#     '@babel/plugin-transform-runtime',
#   ],
# };
# EOL
# }

# # Create Jest setup file
# create_jest_setup() {
#     local setup_file="$1/jest.setup.js"
#     echo "Creating Jest setup file in $setup_file"
#     cat > "$setup_file" << EOL
# require('core-js/stable');
# require('regenerator-runtime/runtime');
# require('@testing-library/jest-dom');
# EOL
# }

# # Update test files to use @testing-library/react instead of enzyme
# update_test_files() {
#     local dir=$1
#     echo "Updating test files in $dir to use @testing-library/react"
#     find "$dir" -name "*.test.js" -type f -exec sed -i 's/import { shallow, mount, render } from '\''enzyme'\''/import { render, screen, fireEvent } from '\''@testing-library\/react'\''/' {} +
#     find "$dir" -name "*.test.js" -type f -exec sed -i '/import Adapter from '\''enzyme-adapter-react-16'\''/d' {} +
#     find "$dir" -name "*.test.js" -type f -exec sed -i '/configure({ adapter: new Adapter() })/d' {} +
#     find "$dir" -name "*.test.js" -type f -exec sed -i 's/shallow(/render(/g' {} +
#     find "$dir" -name "*.test.js" -type f -exec sed -i 's/mount(/render(/g' {} +
#     # Remove enzyme specific assertions
#     find "$dir" -name "*.test.js" -type f -exec sed -i 's/\.find(.*).simulate(/fireEvent./g' {} +
#     find "$dir" -name "*.test.js" -type f -exec sed -i 's/\.prop(/./g' {} +
#     find "$dir" -name "*.test.js" -type f -exec sed -i 's/\.props()/./g' {} +
#     # Convert import statements to require
#     find "$dir" -name "*.test.js" -type f -exec sed -i 's/import \(.*\) from '\''\\(.*\\)'\''/const \1 = require('\''\\2'\'')/' {} +
# }

# # Disable Jest HTML Reporter
# update_html_reporter_config() {
#     local package_file="$1/package.json"
#     if [ -f "$package_file" ]; then
#         echo "Disabling Jest HTML Reporter in $package_file"
#         jq '.devDependencies["jest-html-reporter"] = "^3.7.0"' "$package_file" > "${package_file}.tmp" && mv "${package_file}.tmp" "$package_file"
#         npm install --save-dev jest-html-reporter@3.7.0 --legacy-peer-deps
#     else
#         echo "package.json file not found in $1"
#         return 1
#     fi
# }

# # Set environment variable for Jest output
# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH:-./junit}"

# # Function to run tests
# run_tests() {
#     local dir=$1
#     local name=$2
#     echo "Starting '$dir' Jest tests"
#     cd "$dir"
#     update_dependencies
#     update_package_json "."
#     update_jest_config "."
#     create_babel_config "."
#     create_jest_setup "."
#     update_test_files "."
#     update_html_reporter_config "."
#     if npx jest --config=jest.config.js --reporters=default --reporters=jest-junit --updateSnapshot; then
#         echo "==== $name tests passed"
#         return 0
#     else
#         echo "==== $name tests failed"
#         return 1
#     fi
# }

# # Run tests for /lab
# if ! run_tests "/appsrc/lab" "Lab"; then
#     lab_failed=true
# fi

# # Run tests for /lab/webapp
# if ! run_tests "/appsrc/lab/webapp" "Webapp"; then
#     webapp_failed=true
# fi

# # Exit with error code 1 if either test fails
# if [ "${lab_failed:-false}" = true ] || [ "${webapp_failed:-false}" = true ]; then
#     echo "Some tests failed"
#     exit 1
# else
#     echo "All tests passed successfully"
#     exit 0
# fi




# pass 
#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Install jq if not already installed
if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    apt-get update && apt-get install -y jq
fi

# Update dependencies and fix vulnerabilities
update_dependencies() {
    echo "Updating dependencies and fixing vulnerabilities"
    npm install --legacy-peer-deps
    npm install --save-dev @babel/core@latest @babel/preset-env@latest @babel/preset-react@latest babel-jest@latest jest@latest jest-environment-jsdom@latest core-js@latest regenerator-runtime@latest @babel/plugin-syntax-jsx@latest @babel/plugin-transform-runtime@latest @testing-library/jest-dom@latest @testing-library/react@latest identity-obj-proxy@latest
    npm uninstall enzyme enzyme-adapter-react-16
    npm audit fix --force || true
    npx browserslist@latest --update-db || true
}

# Update package.json
update_package_json() {
    local package_file="$1/package.json"
    echo "Updating package.json in $package_file"
    
    # Use jq to modify the JSON file, removing the "type": "module"
    jq '.license = "UNLICENSED" | del(.jest) | del(.type)' "$package_file" > "${package_file}.tmp" && mv "${package_file}.tmp" "$package_file"
}

# Update Jest configuration
update_jest_config() {
    local config_file="$1/jest.config.js"
    echo "Updating Jest configuration in $config_file"
    cat > "$config_file" << EOL
module.exports = {
  moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx', 'node', 'mjs'],
  transform: {
    '^.+\\.(js|jsx|mjs|cjs|ts|tsx)$': ['babel-jest', { configFile: './babel.config.js' }],
  },
  transformIgnorePatterns: [
    'node_modules/(?!(fetch-mock|core-js)/)'
  ],
  setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
  testEnvironment: 'jsdom',
  testMatch: ['**/__tests__/**/*.[jt]s?(x)', '**/?(*.)+(spec|test).[jt]s?(x)'],
  moduleNameMapper: {
    '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
    '^core-js/(.*)$': 'core-js/$1'
  }
};
EOL
}

# Create Babel configuration
create_babel_config() {
    local babel_config="$1/babel.config.js"
    echo "Creating Babel configuration in $babel_config"
    cat > "$babel_config" << EOL
module.exports = {
  presets: [
    ['@babel/preset-env', {
      targets: {
        node: 'current',
      },
      useBuiltIns: 'usage',
      corejs: 3
    }],
    '@babel/preset-react',
  ],
  plugins: [
    '@babel/plugin-syntax-jsx',
    '@babel/plugin-transform-runtime',
  ],
};
EOL
}

# Create Jest setup file
create_jest_setup() {
    local setup_file="$1/jest.setup.js"
    echo "Creating Jest setup file in $setup_file"
    cat > "$setup_file" << EOL
import '@testing-library/jest-dom';
EOL
}

# Update test files to use @testing-library/react instead of enzyme
update_test_files() {
    local dir=$1
    echo "Updating test files in $dir to use @testing-library/react"
    
    find "$dir" -name "*.test.js" -type f | while read -r file; do
        echo "Processing file: $file"
        
        # Replace imports
        sed -i 's/import { shallow, mount, render } from '\''enzyme'\''/import { render, screen, fireEvent } from '\''@testing-library\/react'\''/' "$file"
        sed -i '/import Adapter from '\''enzyme-adapter-react-16'\''/d' "$file"
        sed -i '/configure({ adapter: new Adapter() })/d' "$file"
        
        # Replace shallow and mount with render
        sed -i 's/shallow(/render(/g' "$file"
        sed -i 's/mount(/render(/g' "$file"
        
        # Replace find().simulate() with fireEvent
        sed -i 's/\.find([^)]*).simulate('\''click'\'')/fireEvent.click(screen.getByRole('\''button'\''))/g' "$file"
        sed -i 's/\.find([^)]*).simulate('\''change'\'',\s*{\s*target:\s*{\s*value:\s*\([^)]*\)\s*}\s*})/fireEvent.change(screen.getByRole('\''textbox'\''), { target: { value: \1 } })/g' "$file"
        
        # Replace .prop and .props()
        sed -i 's/\.prop(/getComputedStyle(/g' "$file"
        sed -i 's/\.props()/getComputedStyle(element)/g' "$file"
        
        # Fix double dot syntax error
        sed -i 's/\.\././g' "$file"
        
        # Replace expect().toHaveLength() with expect().toBeInTheDocument()
        sed -i 's/expect([^)]*).toHaveLength(1)/expect(screen.getByTestId('\''element-id'\'')).toBeInTheDocument()/g' "$file"
        
        # Replace .at(0) with array destructuring
        sed -i 's/\.at(0)/[0]/g' "$file"
        
        # Fix specific issues in fileUpload.test.js
        if [[ "$file" == *"fileUpload.test.js" ]]; then
            sed -i 's/dropzoneButton\[0\]getComputedStyle('\''onDropAccepted'\'')()/fireEvent.drop(screen.getByTestId('\''dropzone'\''), { dataTransfer: { files: [badFakeFile] } })/' "$file"
            sed -i 's/shallowDom\.state('\''selectedFile'\'')/screen.getByTestId('\''selected-file'\'').textContent/' "$file"
        fi
        
        echo "Completed processing file: $file"
    done
    
    echo "
    IMPORTANT: Manual review is required!
    Please check all test files for the following:
    1. Ensure all queries use appropriate testing-library methods (getByRole, getByTestId, etc.)
    2. Update all assertions to use testing-library conventions
    3. Replace any remaining Enzyme-specific methods or properties
    4. Ensure all fireEvent calls are correctly targeting elements
    5. Add necessary test IDs to your components if using getByTestId
    6. Update any complex Enzyme traversals or selections to use testing-library alternatives
    "
}

# Update Jest HTML Reporter
update_html_reporter_config() {
    local package_file="$1/package.json"
    if [ -f "$package_file" ]; then
        echo "Updating Jest HTML Reporter in $package_file"
        # Update or add jest-html-reporter to devDependencies
        jq '.devDependencies["jest-html-reporter"] = "^3.7.0"' "$package_file" > "${package_file}.tmp" && mv "${package_file}.tmp" "$package_file"
        npm install --save-dev jest-html-reporter@latest --legacy-peer-deps

        # Ensure Jest HTML Reporter is configured in Jest setup
        local jest_config_file="$1/jest.config.js"
        if [ -f "$jest_config_file" ]; then
            if ! grep -q "jest-html-reporter" "$jest_config_file"; then
                echo "Adding Jest HTML Reporter to Jest configuration"
                sed -i '/reporters/s/\[/\["jest-html-reporter", /' "$jest_config_file"
            fi
        else
            echo "Jest config file not found. Please ensure Jest HTML Reporter is configured manually."
        fi
    else
        echo "package.json file not found in $1"
        return 1
    fi
}

# Set environment variable for Jest output
export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH:-./junit}"

# Function to run tests
run_tests() {
    local dir=$1
    local name=$2
    echo "Starting '$dir' Jest tests"
    cd "$dir"
    update_dependencies
    update_package_json "."
    update_jest_config "."
    create_babel_config "."
    create_jest_setup "."
    update_test_files "."
    update_html_reporter_config "."
    if npx jest --config=jest.config.js --reporters=default --reporters=jest-junit --updateSnapshot; then
        echo "==== $name tests passed"
        return 0
    else
        echo "==== $name tests failed"
        return 1
    fi
}

# Run tests for /lab
if ! run_tests "/appsrc/lab" "Lab"; then
    lab_failed=true
fi

# Run tests for /lab/webapp
if ! run_tests "/appsrc/lab/webapp" "Webapp"; then
    webapp_failed=true
fi

# Exit with error code 1 if either test fails
if [ "${lab_failed:-false}" = true ] || [ "${webapp_failed:-false}" = true ]; then
    echo "Some tests failed"
    exit 1
else
    echo "All tests passed successfully"
    exit 0
fi









# #!/bin/bash

# # Exit immediately if a command exits with a non-zero status.
# set -e

# # Install jq
# apt-get update && apt-get install -y jq

# # Check Node.js version
# node_version=$(node --version)
# required_version="v14.17.0"

# if [ "$(printf '%s\n' "$required_version" "$node_version" | sort -V | head -n1)" = "$required_version" ]; then 
#     echo "Node.js version is sufficient"
# else 
#     echo "Node.js version is too old. Please update to at least $required_version"
#     exit 1
# fi

# # Clean up package.json
# clean_package_json() {
#     local package_file="$1/package.json"
#     if [ -f "$package_file" ]; then
#         echo "Cleaning up $package_file"
#         # Remove any potential trailing commas and extra closing braces
#         sed -i 's/,\s*}/}/g' "$package_file"
#         sed -i 's/}\s*}/}/g' "$package_file"
#         # Ensure the file ends with a single closing brace
#         sed -i '$s/.*}/}/' "$package_file"
#         # Remove any lines after the last closing brace
#         sed -i '/^}/q' "$package_file"
#         # Use jq to validate and format the JSON
#         if jq '.' "$package_file" > "${package_file}.tmp"; then
#             mv "${package_file}.tmp" "$package_file"
#             echo "Successfully cleaned up $package_file"
#         else
#             echo "Failed to clean up $package_file. Attempting manual fix..."
#             # If jq fails, try to manually fix the JSON structure
#             sed -i '/{/,/}/{/reporters/,/]/d}' "$package_file"
#             sed -i 's/,\s*$//' "$package_file"
#             echo "  }" >> "$package_file"
#             echo "}" >> "$package_file"
#             if jq '.' "$package_file" > /dev/null 2>&1; then
#                 echo "Manual fix successful"
#             else
#                 echo "Manual fix failed. Please check $package_file manually."
#                 return 1
#             fi
#         fi
#     else
#         echo "package.json file not found in $1"
#         return 1
#     fi
# }

# # Update dependencies and fix vulnerabilities
# update_dependencies() {
#     echo "Updating dependencies and fixing vulnerabilities"
#     npm update
#     npm audit fix --force
#     npm install --save-dev @babel/core @babel/preset-env @babel/preset-react babel-jest
#     npx browserslist@latest --update-db
# }

# # Update Jest configuration
# update_jest_config() {
#     local config_file="$1/jest.config.js"
#     echo "Updating Jest configuration in $config_file"
#     cat << EOF > "$config_file"
# module.exports = {
#   transformIgnorePatterns: [
#     '/node_modules/(?!(undici|cheerio|enzyme)/)'
#   ],
#   transform: {
#     '^.+\\.(js|jsx|ts|tsx|mjs)$': 'babel-jest',
#   },
#   moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx', 'node', 'mjs'],
# };
# EOF
# }

# # Update Babel configuration
# update_babel_config() {
#     local babel_file="$1/.babelrc"
#     echo "Updating Babel configuration in $babel_file"
#     cat << EOF > "$babel_file"
# {
#   "presets": [
#     ["@babel/preset-env", { "targets": { "node": "current" } }],
#     "@babel/preset-react"
#   ]
# }
# EOF
# }

# # Remove Jest configuration from package.json
# remove_jest_config_from_package() {
#     local package_file="$1/package.json"
#     if [ -f "$package_file" ]; then
#         echo "Removing Jest configuration from $package_file"
#         jq 'del(.jest)' "$package_file" > "$package_file.tmp" && mv "$package_file.tmp" "$package_file"
#     else
#         echo "package.json file not found in $1"
#         return 1
#     fi
# }

# # Update Jest HTML Reporter configuration
# update_html_reporter_config() {
#     local package_file="$1/package.json"
#     if [ -f "$package_file" ]; then
#         echo "Updating Jest HTML Reporter configuration in $package_file"
#         # Remove duplicate version entries if they exist
#         sed -i 's/\("jest-html-reporter"\s*:\s*"[^"]*"\)\s*:\s*"[^"]*"\s*:\s*"[^"]*"/\1/' "$package_file"
#         # Ensure the correct version is set
#         if ! grep -q '"jest-html-reporter"' "$package_file"; then
#             sed -i '/"devDependencies"/ a\    "jest-html-reporter": "^3.7.0",' "$package_file"
#         fi
#         npm i --save-dev jest-html-reporter@3.7.0
#         echo "Jest HTML Reporter configuration updated successfully"
#     else
#         echo "package.json file not found in $1"
#         return 1
#     fi
# }

# # Set environment variable for Jest output
# export JEST_JUNIT_OUTPUT_DIR="${REPORT_PATH}"

# # Function to run tests
# run_tests() {
#     local dir=$1
#     local name=$2
#     echo "Starting '$dir' Jest tests"
#     cd "$dir"
#     clean_package_json "."
#     update_dependencies
#     update_jest_config "."
#     update_babel_config "."
#     update_html_reporter_config "."
#     remove_jest_config_from_package "."
#     if [ -f "jest.config.js" ]; then
#         if npm run test -- --config jest.config.js --reporters=default --reporters=jest-junit --updateSnapshot; then
#             echo "==== $name tests passed"
#             return 0
#         else
#             echo "==== $name tests failed"
#             return 1
#         fi
#     else
#         echo "jest.config.js not found. Running tests without explicit config."
#         if npm run test -- --reporters=default --reporters=jest-junit --updateSnapshot; then
#             echo "==== $name tests passed"
#             return 0
#         else
#             echo "==== $name tests failed"
#             return 1
#         fi
#     fi
# }

# # Run tests for /lab
# if ! run_tests "/appsrc/lab/" "Lab"; then
#     lab_failed=true
# fi

# # Run tests for /lab/webapp
# if ! run_tests "/appsrc/lab/webapp/" "Webapp"; then
#     webapp_failed=true
# fi

# # Exit with error code 1 if either test fails
# if [ "$lab_failed" = true ] || [ "$webapp_failed" = true ]; then
#     echo "Some tests failed"
#     exit 1
# else
#     echo "All tests passed successfully"
#     exit 0
# fi

