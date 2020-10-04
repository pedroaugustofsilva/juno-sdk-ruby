# frozen_string_literal: true

require 'test_helper'

class BalaceTest < ActiveSupport::TestCase
  def setup
    setup_responses
  end

  def teardown
    ActiveResource::HttpMock.reset!
  end

  def test_request
    Juno::Balance.find(:current)

    expected_request = ActiveResource::Request.new(
      :get,
      '/api-integration/balance',
      nil,
      { 'Accept' => 'application/json', 'Authorization' => 'Bearer eyJhbGciOiJ', 'X-Resource-Token' => 'pr1v4t3', 'X-Api-Version' => '2' }
    )

    assert_includes ActiveResource::HttpMock.requests, expected_request
  end
end
