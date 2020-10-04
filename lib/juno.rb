# frozen_string_literal: true

require 'active_resource'

module Juno
  RESOURCES = [:Transfer].freeze
  SINGULAR_RESOURCES = [:Balance].freeze

  autoload :Authorization, 'juno/authorization.rb'
  autoload :Configuration, 'juno/configuration.rb'
  autoload :Resource, 'juno/resource.rb'
  autoload :SingularResource, 'juno/singular_resource.rb'

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def const_missing(*args)
      constant = args.first

      if resource?(constant)
        Juno.const_set(constant, Class.new(Juno::Resource))
      elsif singular_resource?(constant)
        Juno.const_set(constant, Class.new(Juno::SingularResource))
      else
        super
      end
    end

    def resource?(resource)
      RESOURCES.include?(resource)
    end

    def singular_resource?(resource)
      SINGULAR_RESOURCES.include?(resource)
    end
  end
end
