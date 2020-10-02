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

# Juno.configure do |c|
#   c.client_id = '36MlAdCaIQnKEV9l'
#   c.client_secret = 'sdLcs>QmaKV3F~w1lM*;sD9CEjo$+?0K'
# end
