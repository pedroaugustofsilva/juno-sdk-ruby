# frozen_string_literal: true

require 'http'

module Juno
  class Authorization
    class << self
      def token
        @token ||= access_token
      end

      def refresh_token
        @token = access_token
      end

      private

      def access_token
        url = Juno.configuration.endpoint_for(:authorization)

        response = HTTP.headers(headers).post("#{url}/oauth/token", form: { grant_type: :client_credentials })

        case response.code
        when 200
          JSON.parse(response.body.to_s)['access_token']
        else
          raise 'Invalid authorization'
        end
      end

      def headers
        credentials = [Juno.configuration.client_id, Juno.configuration.client_secret].map(&:to_s).join(':')

        encoded_credentials = Base64.encode64(credentials).tr("\n", '')

        {
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Authorization' => "Basic #{encoded_credentials}"
        }
      end
    end
  end
end
