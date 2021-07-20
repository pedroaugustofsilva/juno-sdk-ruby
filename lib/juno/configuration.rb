# frozen_string_literal: true
#
module Juno
  class Configuration
    POSSIBLES_ENVIRONMENTS = %i[sandbox production].freeze

    attr_accessor :client_id,
                  :client_secret,
                  :private_token

    def initialize
      @environment = POSSIBLES_ENVIRONMENTS.first
    end

    def endpoint_for(type)
      ENDPOINTS.dig(@environment, type)
    end

    def environment=(environment)
      raise ArgumentError, "environment #{environment} is not valid" unless valid_environment?(environment)

      @environment = environment
    end

    private

    ENDPOINTS = {
      sandbox: {
        authorization: 'https://sandbox.boletobancario.com/authorization-server',
        resource: 'https://sandbox.boletobancario.com/api-integration'
      },
      production: {
        authorization: 'https://api.juno.com.br/authorization-server',
        resource: 'https://api.juno.com.br'
      }
    }.freeze

    def base_endpoint
      ENDPOINTS[@environment]
    end

    def valid_environment?(environment)
      POSSIBLES_ENVIRONMENTS.include?(environment.to_sym)
    end
  end
end
