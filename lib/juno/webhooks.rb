module Juno
  class Webhooks < Juno::Resource
    class << self
      def create(body)
        post('/notifications/webhooks', body)
      end

      def list
        get('/notifications/webhooks')
      end

      def show(id)
        get("/notifications/webhooks/#{id}")
      end

      def update(id, body)
        patch("/notifications/webhooks/#{id}", body)
      end

      def remove(id)
        delete("/notifications/webhooks/#{id}")
      end

      def event_types
        get('/notifications/event-types')
      end
    end
  end
end
