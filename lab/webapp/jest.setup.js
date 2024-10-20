// jest.setup.js
// jest.mock("stream", () => {
//   return jest.requireActual("/appsrc/stream");
// });

// global.stream = require("/appsrc/stream");
// global.assert = require("/appsrc/lab/webapp/node_modules/assert");
// global.assert = require("assert");

// // Assert 모듈이 제대로 로드되었는지 확인하는 테스트
// test("assert module is loaded correctly", () => {
//   expect(global.assert).toBeDefined();
//   expect(typeof global.assert).toBe("function");
//   expect(() => global.assert(true)).not.toThrow();
//   expect(() => global.assert(false)).toThrow();
// });

// console.log("Assert module loaded:", global.assert ? "Success" : "Failure");

import assert from "assert";
import net from "net-browserify";

global.assert = assert;
global.net = net;

import http from "http-browserify/lib/request";
import https from "https-browserify";
global.http = http;
global.https = https;

const nodeCrypto = require("crypto");
global.crypto = {
  getRandomValues: function (buffer) {
    return nodeCrypto.randomFillSync(buffer);
  },
};
