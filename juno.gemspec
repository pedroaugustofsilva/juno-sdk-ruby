# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'juno/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'juno'
  spec.version     = Juno::VERSION
  spec.authors     = ['']
  spec.email       = ['']
  spec.homepage    = ''
  spec.files       = Dir['lib/**/**.rb']
  spec.summary     = 'Juno SDK'
  spec.description = 'Juno SDK'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 2.4.0'

  spec.add_runtime_dependency 'faraday'
  spec.add_runtime_dependency 'http'
  spec.add_development_dependency 'rake'
end
