# frozen_string_literal: true

require_relative '../../lib/customers_list'

def format_customer(customer)
  dec_customer = Decorators::CustomerDecorator.new(customer)

  "#{dec_customer.name} | #{dec_customer.email} | #{dec_customer.vehicle_type} |" \
    " #{dec_customer.vehicle.name} | #{dec_customer.vehicle.length_in_inches}"
end

def format_customers(customers)
  customers.map { |c| format_customer(c) }.join("\n")
end

def format_with_header(customers)
  "Name | Email | Vehicle Type | Vehicle Name | Vehicle Length in Inches\n#{format_customers(customers)}"
end

RSpec.describe CustomersList do
  subject(:customers_list) { described_class.new(customers) }

  let(:customer1) { build(:customer, :ansel_adams) }
  let(:customer2) { build(:customer, :steve_irwin) }
  let(:customer3) { build(:customer, :isatou_ceesay) }
  let(:customer4) { build(:customer, :naomi_uemura) }
  let(:customers) { [customer1, customer2, customer3, customer4] }

  describe '#show' do
    subject(:show) { customers_list.show }

    it 'prints customer info' do
      expected = format_with_header(customers)

      expect { show }.to output(expected).to_stdout
    end

    context 'when sorting by name' do
      subject(:show) { customers_list.show(sort: :name) }

      it 'prints sorted customer info' do
        expected = format_with_header([customer1, customer3, customer4, customer2])

        expect { show }.to output(expected).to_stdout
      end
    end
  end

  describe '#sort' do
    subject(:sort) { customers_list.sort(type:, dir:) }

    let(:type) { :name }
    let(:dir)  { :asc }

    context 'when sorting by none' do
      let(:type) { :none }

      it { is_expected.to eq customers }
    end

    context 'when sorting by name' do
      let(:expected) { [customer1, customer3, customer4, customer2] }

      it { is_expected.to eq expected }

      context 'when dir is desc' do
        let(:dir)      { :desc }
        let(:expected) { [customer2, customer4, customer3, customer1] }

        it { is_expected.to eq expected }
      end
    end

    context 'when sorting by last_name' do
      let(:type)     { :last_name }
      let(:expected) { [customer1, customer3, customer2, customer4] }

      it { is_expected.to eq expected }

      context 'when dir is desc' do
        let(:dir)      { :desc }
        let(:expected) { [customer4, customer2, customer3, customer1] }

        it { is_expected.to eq expected }
      end
    end

    context 'when sorting by email' do
      let(:type)     { :email }
      let(:expected) { [customer1, customer3, customer4, customer2] }

      it { is_expected.to eq expected }

      context 'when dir is desc' do
        let(:dir) { :desc }

        let(:expected) { [customer2, customer4, customer3, customer1] }

        it { is_expected.to eq expected }
      end
    end

    context 'when sorting by vehicle type' do
      let(:type)     { :vehicle_type }
      let(:expected) { [customer4, customer3, customer1, customer2] }

      it { is_expected.to eq expected }

      context 'when dir is desc' do
        let(:dir) { :desc }

        let(:expected) { [customer2, customer1, customer3, customer4] }

        it { is_expected.to eq expected }
      end
    end

    context 'when sorting by vehicle name' do
      let(:type)     { :vehicle_name }
      let(:expected) { [customer2, customer4, customer3, customer1] }

      it { is_expected.to eq expected }

      context 'when dir is desc' do
        let(:dir) { :desc }

        let(:expected) { [customer1, customer3, customer4, customer2] }

        it { is_expected.to eq expected }
      end
    end

    context 'when sorting by vehicle length in inches' do
      let(:type)     { :vehicle_length_in_inches }
      let(:expected) { [customer4, customer3, customer1, customer2] }

      it { is_expected.to eq expected }

      context 'when dir is desc' do
        let(:dir) { :desc }

        let(:expected) { [customer2, customer1, customer3, customer4] }

        it { is_expected.to eq expected }
      end
    end

    context 'when sorting by an invalid sort type' do
      let(:type) { :invalid }

      it 'raises an argument error' do
        expect { sort }.to raise_error(ArgumentError)
      end
    end
  end
end
