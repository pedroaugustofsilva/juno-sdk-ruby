# frozen_string_literal: true

require 'test_helper'

class TransferTest < ActiveSupport::TestCase
  def setup
    setup_responses
  end

  def teardown
    ActiveResource::HttpMock.reset!
  end

  def test_request
    attributes = {
      "type": 'BANK_ACCOUNT',
      "name": 'Megafono Serviços de Hospedagem na Internet LTDA',
      "document": '35135533000165',
      "amount": '42342',
      "bankAccount": {
        "bankNumber": '218',
        "agencyNumber": '0001',
        "accountNumber": '6165800',
        "accountType": 'CHECKING',
        "accountHolder": 'Megafono Serviços de Hospedagem na Internet LTDA'
      }
    }

    Juno::Transfer.create(attributes)

    expected_request = ActiveResource::Request.new(
      :post,
      '/api-integration/transfers',
      attributes.to_json,
      { 'Content-Type' => 'application/json', 'Authorization' => 'Bearer eyJhbGciOiJ', 'X-Resource-Token' => 'pr1v4t3', 'X-Api-Version' => '2' }
    )

    assert_includes ActiveResource::HttpMock.requests, expected_request
  end
end
