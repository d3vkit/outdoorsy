# frozen_string_literal: true

require 'faker'
require_relative '../../lib/models/customer'

FactoryBot.define do
  factory :customer, class: Models::Customer do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    vehicle { build(:vehicle) }

    initialize_with { new(first_name:, last_name:, email:, vehicle:) }

    trait :ansel_adams do
      first_name { 'Ansel' }
      last_name { 'Adams' }
      email { 'a@adams.com' }
      vehicle { build(:vehicle, type: 'motorboat', name: 'Rushing Water', length: "24'") }
    end

    trait :steve_irwin do
      first_name { 'Steve' }
      last_name { 'Irwin' }
      email { 'steve@crocodiles.com' }
      vehicle { build(:vehicle, type: 'RV', name: "G'Day For Adventure", length: '32 ft') }
    end

    trait :isatou_ceesay do
      first_name { 'Isatou' }
      last_name { 'Ceesay' }
      email { 'isatou@recycle.com' }
      vehicle { build(:vehicle, type: 'campervan', name: 'Plastic To Purses', length: "20'") }
    end

    trait :naomi_uemura do
      first_name { 'Naomi' }
      last_name { 'Uemura' }
      email { 'n.uemura@gmail.com' }
      vehicle { build(:vehicle, type: 'bicycle', name: 'Glacier Glider', length: '5 feet') }
    end
  end
end
