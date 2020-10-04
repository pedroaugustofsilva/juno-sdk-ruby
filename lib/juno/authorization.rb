# frozen_string_literal: true

module Juno
  class Authorization < Resource
    class Error < StandardError; end
    self.collection_name = 'oauth/token'

    self.site = Juno.configuration.endpoint_for(:authorization)

    class << self
      def current
        _current
      end

      def headers
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

      private

      def _current
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
    end
  end
end
