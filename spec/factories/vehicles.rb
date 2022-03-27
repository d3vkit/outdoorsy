# frozen_string_literal: true

require_relative '../../lib/models/vehicle'

FactoryBot.define do
  factory :vehicle, class: Models::Vehicle do
    type { 'sailboat' }
    name { 'Fridays For Future' }
    length { "32'" }

    initialize_with { new(type:, name:, length:) }
  end
end
