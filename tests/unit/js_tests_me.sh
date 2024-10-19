# # #!/bin/bash

# # # Exit immediately if a command exits with a non-zero status.
# # set -e

# # # Install jq if not already installed
# # if ! command -v jq &> /dev/null; then
# #     echo "Installing jq..."
# #     apt-get update && apt-get install -y jq
# # fi

# # # Update dependencies and fix vulnerabilities
# # update_dependencies() {
# #     echo "Updating dependencies and fixing vulnerabilities"
# #     npm install --legacy-peer-deps
# #     npm install --save-dev @babel/core@latest @babel/preset-env@latest @babel/preset-react@latest babel-jest@latest jest@latest jest-environment-jsdom@latest core-js@latest regenerator-runtime@latest @babel/plugin-syntax-jsx@latest @babel/plugin-transform-runtime@latest @testing-library/jest-dom@latest @testing-library/react@latest identity-obj-proxy@latest
# #     npm uninstall enzyme enzyme-adapter-react-16
# #     npm audit fix --force || true
# #     npx browserslist@latest --update-db || true
# # }

# # # Update package.json
# # update_package_json() {
# #     local package_file="$1/package.json"
# #     echo "Updating package.json in $package_file"
    
# #     # Use jq to modify the JSON file, removing the "type": "module"
# #     jq '.license = "UNLICENSED" | del(.jest) | del(.type)' "$package_file" > "${package_file}.tmp" && mv "${package_file}.tmp" "$package_file"
# # }

# # # Update Jest configuration
# # update_jest_config() {
# #     local config_file="$1/jest.config.js"
# #     echo "Updating Jest configuration in $config_file"
# #     cat > "$config_file" << EOL
# # module.exports = {
# #   moduleFileExtensions: ['js', 'json', 'jsx', 'ts', 'tsx', 'node', 'mjs'],
# #   transform: {
# #     '^.+\\.(js|jsx|mjs|cjs|ts|tsx)$': ['babel-jest', { configFile: './babel.config.js' }],
# #   },
# #   transformIgnorePatterns: [
# #     'node_modules/(?!(fetch-mock|core-js)/)'
# #   ],
# #   setupFilesAfterEnv: ['/jest.setup.js'],
# #   testEnvironment: 'jsdom',
# #   testMatch: ['**/__tests__/**/*.[jt]s?(x)', '**/?(*.)+(spec|test).[jt]s?(x)'],
# #   moduleNameMapper: {
# #     '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
# #     '^core-js/(.*)$': 'core-js/$1'
# #   }
# # };
# # EOL
# # }

# # # Create Babel configuration
# # create_babel_config() {
# #     local babel_config="$1/babel.config.js"
# #     echo "Creating Babel configuration in $babel_config"
# #     cat > "$babel_config" << EOL
# # module.exports = {
# #   presets: [
# #     ['@babel/preset-env', {
# #       targets: {
# #         node: 'current',
# #       },
# #       useBuiltIns: 'usage',
# #       corejs: 3
# #     }],
# #     '@babel/preset-react',
# #   ],
# #   plugins: [
# #     '@babel/plugin-syntax-jsx',
# #     '@babel/plugin-transform-runtime',
# #   ],
# # };
# # EOL
# # }

# # # Create Jest setup file
# # create_jest_setup() {
# #     local setup_file="$1/jest.setup.js"
# #     echo "Creating Jest setup file in $setup_file"
# #     cat > "$setup_file" << EOL
# # import '@testing-library/jest-dom';
# # EOL
# # }

# # # Function to create the actionsTemp.test.js file in src/data/recommender
# # create_actions_temp_test() {
# #     local recommender_dir="$1/src/data/recommender"
# #     local test_file="$recommender_dir/actionsTemp.test.js"

# #     if [ ! -d "$recommender_dir" ]; then
# #         echo "Directory $recommender_dir not found!"
# #         exit 1
# #     fi

# #     echo "Creating actionsTemp.test.js in $recommender_dir"
# #     cat > "$test_file" << EOL
# # import * as actions from './actions'

# # import 'isomorphic-fetch'
# # import fetchMock from 'fetch-mock'
# # import configureMockStore from 'redux-mock-store'
# # import thunk from 'redux-thunk'

# # const middlewares = [thunk]
# # const mockStore = configureMockStore(middlewares)
# # fetchMock.config.sendAsJson = true

# # describe ('async actions', () => {
# # 	afterEach(() => {
# # 		fetchMock.restore()
# # 	})

# # 	it('create FETCH_RECOMMENDER_SUCCESS when fetching recommender has been done', () => {
# # 		const recObject = {
# # 			    "_id": "5e8bdb51cb325e6349a450c9",
# # 			    "type": "recommender",
# # 			    "status": "disabled"
# # 			}

# # 		fetchMock.getOnce('path:/api/recommender', {
# # 			body: recObject
# # 		})

# # 		const expectedActions = [
# # 			{ type: actions.FETCH_RECOMMENDER_REQUEST},
# # 			{ type: actions.FETCH_RECOMMENDER_SUCCESS, payload: recObject }
# # 		]
# # 		const store = mockStore()

# # 	    return store.dispatch(actions.fetchRecommender()).then(() => {
# # 	      // return of async actions
# # 	      expect(store.getActions()).toEqual(expectedActions)
# # 	    })
# # 	})

# # })
# # EOL
# # }

# # # Function to run Jest tests
# # run_tests() {
# #     echo "Running Jest tests..."
# #     if npm run test; then
# #         echo "All tests passed successfully!"
# #     else
# #         echo "Some tests failed. Check the output above for details."
# #         exit 1
# #     fi
# # }

# # # Main script logic
# # main() {
# #     local project_root="$1"
    
# #     # Check if project root directory exists
# #     if [ ! -d "$project_root" ]; then
# #         echo "Project root directory $project_root not found!"
# #         exit 1
# #     fi
    
# #     update_dependencies
# #     update_package_json "$project_root"
# #     update_jest_config "$project_root"
# #     create_babel_config "$project_root"
# #     create_jest_setup "$project_root"
# #     create_actions_temp_test "$project_root"
    
# #     # Run the tests and display result
# #     run_tests
# # }

# # # Run the main function
# # main "$(pwd)"




# # v2
# #!/bin/bash


# # Check if package.json exists
# check_package_json() {
#     local dir=$1
#     if [ ! -f "$dir/package.json" ]; then
#         echo "Error: No package.json found in $dir"
#         return 1
#     fi
#     return 0
# }

# # Install dependencies and fix vulnerabilities if package.json exists
# update_dependencies() {
#     local dir=$1
#     if check_package_json "$dir"; then
#         echo "Updating dependencies and fixing vulnerabilities in $dir"
#         cd "$dir"  # Move to the directory where package.json exists
#         npm install --legacy-peer-deps
#         npm install --save-dev @babel/core@latest @babel/preset-env@latest @babel/preset-react@latest babel-jest@latest jest@latest jest-environment-jsdom@latest core-js@latest regenerator-runtime@latest @babel/plugin-syntax-jsx@latest @babel/plugin-transform-runtime@latest @testing-library/jest-dom@latest @testing-library/react@latest identity-obj-proxy@latest
#         npm uninstall enzyme enzyme-adapter-react-16
#         npm audit fix --force || true
#         npx update-browserslist-db@latest || true
#     else
#         echo "Skipping dependency updates due to missing package.json"
#     fi
# }

# # Update package.json
# update_package_json() {
#     local package_file="$1/package.json"
#     if check_package_json "$1"; then
#         echo "Updating package.json in $package_file"
#         jq '.license = "UNLICENSED" | del(.jest) | del(.type)' "$package_file" > "${package_file}.tmp" && mv "${package_file}.tmp" "$package_file"
#     fi
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
#     'node_modules/(?!(fetch-mock|core-js)/)'
#   ],
#   setupFilesAfterEnv: ['<rootDir>/jest.setup.js'],
#   testEnvironment: 'jsdom',
#   testMatch: ['**/__tests__/**/*.[jt]s?(x)', '**/?(*.)+(spec|test).[jt]s?(x)'],
#   moduleNameMapper: {
#     '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
#     '^core-js/(.*)$': 'core-js/$1'
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
#       useBuiltIns: 'usage',
#       corejs: 3
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
# import '@testing-library/jest-dom';
# EOL
# }

# # Function to run tests
# run_tests() {
#     local dir=$1
#     local name=$2
#     echo "Starting '$dir' Jest tests"
#     if check_package_json "$dir"; then
#         update_dependencies "$dir"
#         update_package_json "$dir"
#         update_jest_config "$dir"
#         create_babel_config "$dir"
#         create_jest_setup "$dir"
#         # Run Jest only for actionsTemp.test.js
#         cd "$dir"
#         if npx jest "actionsTemp.test.js" --reporters=default --reporters=jest-junit --updateSnapshot; then
#             echo "==== $name tests passed"
#             return 0
#         else
#             echo "==== $name tests failed"
#             return 1
#         fi
#     else
#         echo "Skipping tests due to missing package.json"
#         return 1
#     fi
# }

# # Run tests for /appsrc/lab
# if ! run_tests "/appsrc/lab" "Lab"; then
#     lab_failed=true
# fi

# # Run tests for /appsrc/lab/webapp
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



