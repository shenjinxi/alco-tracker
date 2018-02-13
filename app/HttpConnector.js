'use strict';

const got = require('got');
const tmplCompile = require('string-template/compile');
const debug = require('debug')('http-connector');
const NodeCache = require('node-cache');
const crypto = require('crypto');

function createHash(data) {

  return crypto.createHash('sha1').update(data).digest('base64');

}


class HTTPConnector {

  constructor(options) {

    if (!options.url) {
      console.warn('HTTPConnector: You should provide api url');
    }

    this.options = options;
    this.url = tmplCompile(options.url);
    this.gotOptions = {
      timeout: 5000,
      retries: 2,
      json: options.json === true
    };
    this.cacheTTL = 300;
    this.cache = new NodeCache({
      stdTTL: this.cacheTTL,
      checkperiod: 310,
      useClones: false
    });
  }

  query(params) {

    const url = this.url(params);
    const requestKey = createHash(Object.values(params).join(''));

    const cached = this.cache.get(requestKey);
    if (cached) {
      return JSON.parse(cached);
    }

    return got(url, Object.assign({}, this.gotOptions, {query: params})).then(
      response => {

        const {body} = response;

        if (body && body.success) {
          this.cache.set(requestKey, JSON.stringify(body));
        } else {
          console.error('HTTPConnector: Wrong answer', body);
        }

        return body;

      }).catch(err => {

      console.error(`HTTPConnector| url:${url}; message:${err.message}; body:${err.response && err.response.body}`, );
      return {
        success: false,
        error: err.message
      };

    });
  }
}


module.exports = HTTPConnector;
