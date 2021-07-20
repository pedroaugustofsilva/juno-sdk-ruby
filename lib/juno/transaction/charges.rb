# frozen_string_literal: true

module Juno
  class Charges < Juno::Resource
    class << self
      def create(body)
        post('/charges', body)
      end

      def list
        get('/charges')
      end

      def show(id)
        get("/charges/#{id}")
      end

      def cancel(id)
        put("/charges/#{id}/cancelation")
      end

      def update_split(id)
        put("/charges/#{id}/split")
      end
    end
  end
end
