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

      def valid_signature?(signature, secret, payload)
        our_signature = OpenSSL::HMAC.hexdigest('SHA256', secret, payload)

        our_signature.eql?(signature)
      end
    end
  end
end
