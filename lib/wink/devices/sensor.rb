module Wink
  module Devices
    class Sensor < Device
      def initialize(client, device)
        super
        @device_id = device.fetch("sensor_pod_id")
      end

      def name
        device["name"]
      end

    end
  end
end