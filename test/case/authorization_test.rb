# frozen_string_literal: true

require 'test_helper'

class AuthorizationTest < ActiveSupport::TestCase
  def teardown
    ActiveResource::HttpMock.reset!
  end

  def test_request
    setup_responses

    auth = Juno::Authorization.current

    expected_request = ActiveResource::Request.new(
      :post,
      '/authorization-server/oauth/token',
      'grant_type=client_credentials',
      {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => 'Basic Y2wxM250XzFkOnMzY3IzdA=='
      }
    )

    assert_includes ActiveResource::HttpMock.requests, expected_request

    assert_equal auth.access_token, 'eyJhbGciOiJ'
    assert_equal auth.expires_in, 86_399
  end

  def test_401_responses
    ActiveResource::HttpMock.respond_to do |mock|
      mock.post(
        '/authorization-server/oauth/token',
        { 'Content-Type' => 'application/x-www-form-urlencoded', 'Authorization' => 'Basic Y2wxM250XzFkOnMzY3IzdA==' },
        authorization_successed_body.to_json, '401', {}
      )
    end

    assert_raises Juno::Authorization::Error do
      Juno::Authorization.current
    end
  end

  def test_others_responses
    ActiveResource::HttpMock.respond_to do |mock|
      mock.post(
        '/authorization-server/oauth/token',
        { 'Content-Type' => 'application/x-www-form-urlencoded', 'Authorization' => 'Basic Y2wxM250XzFkOnMzY3IzdA==' }, nil, '302', {}
      )
    end

    assert_raises Juno::Authorization::Error do
      Juno::Authorization.current
    end
  end
end
