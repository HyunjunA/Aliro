const path = require('path');

module.exports = {
  transform: {
    '^.+\.(js|jsx|ts|tsx)$': 'babel-jest',
  },
  moduleNameMapper: {
    '^node:(.*)$': '<rootDir>/node_modules/',
  },
  setupFilesAfterEnv: ['./jest.setup.js'],
  testEnvironment: 'jsdom',
  moduleDirectories: ['node_modules', path.join(__dirname, 'src')],
  transformIgnorePatterns: [
    'node_modules/(?!(parse5-parser-stream)/)',
  ],
};
