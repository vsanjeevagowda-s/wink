module Wink
  module Devices
    class Lock < Device
      def initialize(client, device)
        super
        @device_id = device.fetch("lock_id")
      end

      def name
        device["name"]
      end

      def lock
        set_state true
      end

      def unlock
        set_state false
      end

      private

      def set_state(state)
        body = {
          :desired_state => {
            :locked => !!state
          }
        }

        response = client.put('/locks{/lock}', :lock => device_id, :body => body)
        response.success?
      end

    end
  end
end
