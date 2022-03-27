# frozen_string_literal: true

module Models
  class Vehicle
    attr_reader :type, :name, :length

    def initialize(type:, name:, length:)
      @type = type
      @name = name
      @length = length
    end
  end
end
