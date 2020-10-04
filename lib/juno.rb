# frozen_string_literal: true

require 'active_resource'

require 'juno/configuration'

module Juno
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end

require 'juno/authorization'
require 'juno/resources'
