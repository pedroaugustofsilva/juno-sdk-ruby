# frozen_string_literal: true

module Juno
  class Authorization < ActiveResource::Base
    self.site = Juno.configuration.endpoint_for(:authorization)
    self.prefix = '/oauth/'
    self.collection_name = 'token'

    def self.current
      @current ||= begin
        response = connection.post("#{prefix}#{collection_name}", 'grant_type=client_credentials', headers)

        if response.success?
          new(response.body)
        else
          raise ArgumentError
        end
      end
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
