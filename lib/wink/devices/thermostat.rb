module Wink
  module Devices
    class Thermostat < Device
      def initialize(client, device)
        super
        @device_id = device.fetch("thermostat_id")
      end

      def name
        device["name"]
      end

      def powered
        device["last_reading"]["powered"]
      end

      def users
        response = client.get('/light_bulbs{/light_bulb}/users', :light_bulb => device_id)
        response.body["data"]
      end

      def subscriptions
        response = client.get('/light_bulbs{/light_bulb}/subscriptions', :light_bulb => device_id)
        response.body["data"]
      end

      def on
        set_state true
      end

      def off
        set_state false
      end

      def in
        set_users_away true
      end

      def out
        set_users_away false
      end

      def fan_on
        set_fan_timer true
      end

      def fan_off
        set_fan_timer false
      end

      private

      def heating_set_point(scale)
        body = {
          :desired_state => {
            :powered => true,
            :max_set_point => scale
          }
        }
        response = client.put('/thermostats{/thermostat}', :thermostat => device_id, :body => body)
        response.success?
      end

      def cooling_set_point(scale)
        body = {
          :desired_state => {
            :powered => true,
            :min_set_point => scale
          }
        }
        response = client.put('/thermostats{/thermostat}', :thermostat => device_id, :body => body)
        response.success?
      end

      def eco_max_set_point(scale)
        body = {
          :desired_state => {
            :powered => true,
            :eco_max_set_point => scale
          }
        }
        response = client.put('/thermostats{/thermostat}', :thermostat => device_id, :body => body)
        response.success?
      end

      def eco_min_set_point(scale)
        body = {
          :desired_state => {
            :powered => true,
            :eco_min_set_point => scale
          }
        }
        response = client.put('/thermostats{/thermostat}', :thermostat => device_id, :body => body)
        response.success?
      end

      def thermostat_mode(scale)
        body = {
          :desired_state => {
            :powered => true,
            :mode => scale
          }
        }
        response = client.put('/thermostats{/thermostat}', :thermostat => device_id, :body => body)
        response.success?
      end

      def set_state(state)
        body = {
          :desired_state => {
            :powered => !!state
          }
        }
        response = client.put('/thermostats{/thermostat}', :thermostat => device_id, :body => body)
        response.success?
      end

      def set_users_away(state)
        body = {
          :desired_state => {
            :powered => true,
            :users_away => !!state
          }
        }
        response = client.put('/thermostats{/thermostat}', :thermostat => device_id, :body => body)
        response.success?
      end

      def set_fan_timer(state)
        body = {
          :desired_state => {
            :powered => true,
            :fan_timer_active => !!state
          }
        }
        response = client.put('/thermostats{/thermostat}', :thermostat => device_id, :body => body)
        response.success?
      end

    end
  end
end
