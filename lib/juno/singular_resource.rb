# frozen_string_literal: true

module Juno
  class SingularResource < Juno::Resource
    def self.element_path(_id, prefix_options = {}, query_options = nil)
      check_prefix_options(prefix_options)

      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{element_name}#{format_extension}#{query_string(query_options)}"
    end
  end
end
