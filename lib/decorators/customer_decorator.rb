# frozen_string_literal: true

require 'delegate'

require_relative 'base_decorator'
require_relative 'vehicle_decorator'

module Decorators
  class CustomerDecorator < BaseDecorator
    def vehicle
      @vehicle ||= VehicleDecorator.new(__getobj__.vehicle)
    end

    def vehicle_length_in_inches
      vehicle.length_in_inches
    end

    def to_s
      "#{name} | #{email} | #{vehicle.type} | #{vehicle.name} | #{vehicle.length_in_inches}"
    end
  end
end
