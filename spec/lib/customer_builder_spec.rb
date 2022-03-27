# frozen_string_literal: true

require_relative '../../lib/customer_builder'

RSpec.describe CustomerBuilder do
  describe '.from_row' do
    subject(:from_row) { described_class.from_row(row) }

    let(:row) { ['Greta', 'Thunberg', 'greta@future.com', 'sailboat', 'Fridays For Future', "32'"] }

    it { is_expected.to be_a Models::Customer }

    it 'assigns first name' do
      expect(from_row.first_name).to eq 'Greta'
    end

    it 'assigns last name' do
      expect(from_row.last_name).to eq 'Thunberg'
    end

    it 'assigns email' do
      expect(from_row.email).to eq 'greta@future.com'
    end

    it 'assigns vehicle type' do
      expect(from_row.vehicle_type).to eq 'sailboat'
    end

    it 'assigns vehicle name' do
      expect(from_row.vehicle_name).to eq 'Fridays For Future'
    end

    it 'assigns vehicle length' do
      expect(from_row.vehicle_length).to eq "32'"
    end
  end
end
