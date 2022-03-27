# frozen_string_literal: true

require 'delegate'

require_relative 'base_decorator'

module Decorators
  class VehicleDecorator < BaseDecorator
    def to_s
      "#{name} | #{length_in_inches}"
    end

    def formatted_length
      matches = /\A([0-9]+)\s*(?:ft|feet|'|’)(?:,)?\s*(?:([0-9]+)\s*(?:in|inches|"|”)?)?\z/.match(length)

      return unless matches

      str = "#{matches[1]}'"
      str += " #{matches[2]}\"" if matches[2]

      str
    end

    def length_in_inches
      length_arr = formatted_length.split.map { |str| str.tr('"\'', '').to_i }

      feet = (length_arr[0] * 12)
      inches = length_arr[1] || 0

      feet + inches
    end
  end
end
