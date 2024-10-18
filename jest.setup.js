const Enzyme = require('enzyme');
const Adapter = require('enzyme-adapter-react-16');

Enzyme.configure({ adapter: new Adapter() });

// Node.js 내장 모듈에 대한 폴리필
global.TextEncoder = require('util').TextEncoder;
global.TextDecoder = require('util').TextDecoder;
