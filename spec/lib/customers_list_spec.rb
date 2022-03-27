# frozen_string_literal: true

require 'hirb'

require_relative '../../lib/customers_list'

def format_customer(customer)
  Decorators::CustomerDecorator.new(customer).to_table
end

def format_customers(customers)
  customers.map { |c| format_customer(c) }
end

def render_customers(customers)
  headers = ['Name', 'Email', 'Vehicle Type', 'Vehicle Name', 'Vehicle Length in Inches']

  Hirb::Helpers::AutoTable.render(format_customers(customers), headers:)
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
      expected = render_customers(customers)

      expect { show }.to output(expected).to_stdout
    end

    context 'when sorting by name' do
      subject(:show) { customers_list.show(sort: :name) }

      it 'prints sorted customer info' do
        expected = render_customers([customer1, customer3, customer4, customer2])

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

      context 'when dir is desc' do
        let(:dir)      { :desc }
        let(:expected) { [customer4, customer3, customer2, customer1] }

        it { is_expected.to eq expected }
      end
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
