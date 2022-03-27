# frozen_string_literal: true

require 'faker'
require_relative '../../lib/models/vehicle'

FactoryBot.define do
  factory :vehicle, class: Models::Vehicle do
    type { %w[sailboat yacht motorboat rv campervan bicycle].sample }
    name { Faker::Restaurant.name }
    length { "32'" }

    initialize_with { new(type:, name:, length:) }
  end
end
