# frozen_string_literal: true

require_relative '../../lib/customers_list'

def expected_print(customer)
  expected = "#{customer.name} | #{customer.email} | #{customer.vehicle_type} | #{customer.vehicle_name} |"
  expected += " #{customer.vehicle_length}"

  expected
end

RSpec.describe CustomersList do
  subject(:customers_list) { described_class.new(customers) }

  let(:customers) { [customer1, customer2] }
  let(:customer1) { build(:customer) }
  let(:customer2) { build(:customer) }

  describe '#show' do
    subject(:show) { customers_list.show }

    it 'prints customer info' do
      expected = "Name | Email | Vehicle Type | Vehicle Name | Vehicle Length\n"
      expected += expected_print(customer1)
      expected += "\n"
      expected += expected_print(customer2)

      expect { show }.to output(expected).to_stdout
    end
  end
end
