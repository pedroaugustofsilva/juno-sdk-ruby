# frozen_string_literal: true

module Juno
  class Resource < ActiveResource::Base
    self.site = Juno.configuration.endpoint_for(:resource)

    class << self
      def headers
        self._headers = superclass.headers
                                  .merge(_headers || {})
                                  .merge(authorization_header)
                                  .merge(resource_token_header)
                                  .merge('X-Api-Version' => '2')
      end

      def current_authorization
        @current_authorization ||= Juno::Authorization.current
      end

      private

      def authorization_header
        { 'Authorization' => current_authorization.access_token }
      end

      def resource_token_header
        { 'X-Resource-Token' => Juno.configuration.private_token }
      end
    end
  end
end
