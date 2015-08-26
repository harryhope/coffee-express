# routes-spec.coffee
# Test server routes.
process.env.NODE_ENV = 'test'
should = require 'should'
request = require 'supertest'
app = require '../server'

describe 'Routes', ->
  describe 'Root Directory', ->
    it 'should resolve', (done) ->
      request app
        .get '/'
        .expect 200
        .end (error, response) ->
          if error then throw error
          response.body.should.not.equal null
          done()
