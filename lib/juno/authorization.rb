# frozen_string_literal: true

module Juno
  class Authorization < ActiveResource::Base
    class Error < StandardError; end

    self.site = Juno.configuration.endpoint_for(:authorization)
    self.collection_name = 'oauth/token'

    def self.current
      response = connection.post("#{prefix}#{collection_name}", 'grant_type=client_credentials', headers)

      case response.code.to_i
      when 200
        new(JSON.parse(response.body))
      else
        raise AuthorizationError, response.inspect
      end
    rescue StandardError => e
      raise Juno::Authorization::Error, e.message
    end

    def self.headers
      credentials = [
        Juno.configuration.client_id,
        Juno.configuration.client_secret
      ].map(&:to_s).join(':')

      encoded_credentials = Base64.encode64(credentials).tr("\n", '')

      {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'Authorization' => "Basic #{encoded_credentials}"
      }
    end
  end
end
