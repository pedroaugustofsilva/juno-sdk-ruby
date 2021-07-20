# frozen_string_literal: true

require 'http'

module Juno
  class Resource
    class << self
      def post(path, body)
        req(:post, path, body)
      end

      def patch(path, body)
        req(:patch, path, body)
      end

      def get(path)
        req(:get, path)
      end

      def delete(path)
        req(:delete, path)
      end

      def put(path, body = {})
        req(:put, path, body)
      end

      private

      def req(method, path, body = {}, fallback = true)
        res = HTTP.headers(headers).send(method, "#{endpoint}#{path}", json: body)

        if res.code.eql?(401) && fallback
          Juno::Authorization.refresh_token
          req(method, path, body, false)
        else
          body = res.code.eql?(204) ? '' : JSON.parse(res.body.to_s)
          { body: body, code: res.code }
        end
      end

      def endpoint
        Juno.configuration.endpoint_for(:resource)
      end

      def headers
        {
          'Content-Type': 'application/json;charset=UTF-8',
          'X-Resource-Token': Juno.configuration.private_token,
          'Authorization': "Bearer #{Juno::Authorization.token}",
          'X-Api-Version': 2
        }
      end
    end
  end
end
