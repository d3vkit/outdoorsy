# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'
require_relative 'vehicle'

module Models
  class Customer
    attr_reader :first_name, :last_name, :email, :vehicle

    delegate :type, :length, to: :vehicle, prefix: :vehicle

    def initialize(first_name:, last_name:, email:, vehicle:)
      validate_input(vehicle)

      @first_name = first_name
      @last_name = last_name
      @email = email
      @vehicle = vehicle
    end

    def name
      "#{first_name} #{last_name}"
    end

    def vehicle_name
      vehicle.name
    end

    private

    def validate_input(vehicle)
      raise ArgumentError, 'Vehicle must be a type of class Vehicle' unless vehicle.is_a?(Vehicle)
    end
  end
end
