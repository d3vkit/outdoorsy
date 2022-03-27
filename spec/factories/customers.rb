# frozen_string_literal: true

require_relative '../../lib/models/customer'

FactoryBot.define do
  factory :customer, class: Models::Customer do
    first_name { 'Greta' }
    last_name { 'Thunberg' }
    email { 'greta@future.com' }
    vehicle { build(:vehicle) }

    initialize_with { new(first_name:, last_name:, email:, vehicle:) }
  end
end
