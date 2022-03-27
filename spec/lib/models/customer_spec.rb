# frozen_string_literal: true

require_relative '../../../lib/models/customer'

RSpec.describe Models::Customer do
  subject(:customer_result) do
    described_class.new(
      first_name: customer.first_name,
      last_name: customer.last_name,
      email: customer.email,
      vehicle: customer.vehicle
    )
  end

  let(:customer) { build(:customer) }

  describe '#name' do
    subject(:name) { customer_result.name }

    it { is_expected.to eq "#{customer.first_name} #{customer.last_name}" }
  end
end
