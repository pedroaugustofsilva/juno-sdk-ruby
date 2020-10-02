# frozen_string_literal: true

require_relative 'resource'
require_relative 'singular_resource'

%w[transfer].each do |resource|
  Juno.const_set(resource.classify, Class.new(Juno::Resource))
end

%w[balance].each do |resource|
  Juno.const_set(resource.classify, Class.new(Juno::SingularResource))
end
