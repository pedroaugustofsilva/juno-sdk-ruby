# frozen_string_literal: true

module Juno
  autoload :Authorization, 'juno/authorization.rb'
  autoload :Configuration, 'juno/configuration.rb'
  autoload :Transaction, 'juno/charges.rb'
  autoload :Webhooks, 'juno/webhooks.rb'
  autoload :Resource, 'juno/resource.rb'

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
