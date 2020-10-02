# frozen_string_literal: true

require 'rubygems' unless defined? Gem
require 'bundler/setup'

lib = File.expand_path("#{File.dirname(__FILE__)}/../lib")
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?('lib') || $LOAD_PATH.include?(lib)

require 'minitest/autorun'

require 'byebug'

require 'active_support'
require 'active_support/test_case'
require 'active_resource'
# require "setter_trap"
# require "active_support/logger"

ActiveSupport::TestCase.test_order = :random if ActiveSupport::TestCase.respond_to?(:test_order=)
ActiveResource::Base.logger = ActiveSupport::Logger.new("#{File.dirname(__FILE__)}/debug.log")
# ActiveResource::Base.include_root_in_json = true

require 'juno'

Juno.configure do |config|
  config.client_id = 'cl13nt_1d'
  config.client_secret = 's3cr3t'
  config.private_token = 'pr1v4t3'
end

ActiveResource::HttpMock.respond_to do |mock|
  mock.post(
    '/oauth/token',
    {
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Authorization' => 'Basic Y2wxM250XzFkOnMzY3IzdA=='
    },
    {
      "access_token": 'eyJhbGciOiJ',
      "token_type": 'bearer',
      "expires_in": 86_399,
      "scope": 'all',
      "user_name": 'user@domain.com',
      "jti": '973a0f5b-570f-4993-bebf-b56fdd22804d'
    },
    200,
    {

    }
  )

  mock.post(
    '/api-integration/transfers',
    {
      'Content-Type' => 'application/json',
      'Authorization' => 'eyJhbGciOiJ',
      'X-Resource-Token' => 'pr1v4t3',
      'X-Api-Version' => '2'
    },
    {
      "id": 'string',
      "digitalAccountId": 'string',
      "creationDate": 'yyyy-MM-dd HH:mm:ss',
      "transferDate": 'yyyy-MM-dd HH:mm:ss',
      "amount": 0,
      "status": 'string',
      "recipient": {
        "name": 'string',
        "document": 'string',
        "bankAccount": {
          "bankNumber": 'string',
          "agencyNumber": 'string',
          "accountNumber": 'string',
          "accountComplementNumber": '001',
          "accountType": 'CHECKING',
          "accountHolder": {
            "name": 'string',
            "document": 'string'
          }
        }
      },
      "_links": [
        {
          "self": {
            "href": 'string'
          }
        }
      ]
    }.to_json,
    201,
    {}
  )

  mock.get(
    '/api-integration/balance',
    {
      'Accept' => 'application/json',
      'Authorization' => 'eyJhbGciOiJ',
      'X-Resource-Token' => 'pr1v4t3',
      'X-Api-Version' => '2'
    },
    {
      "balance": 0,
      "withheldBalance": 0,
      "transferableBalance": 0,
      "_links": [
        {
          "self": {
            "href": 'string'
          }
        }
      ]
    }.to_json,
    200,
    {
    }
  )
end
