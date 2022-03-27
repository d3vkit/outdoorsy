# frozen_string_literal: true

require_relative '../../../lib/decorators/vehicle_decorator'

RSpec.describe Decorators::VehicleDecorator do
  subject(:decorated_vehicle) { described_class.new(vehicle) }

  let(:vehicle) { build(:vehicle, length:) }
  let(:length)  { "12'" }

  describe '#formatted_length' do
    subject(:name) { decorated_vehicle.formatted_length }

    context 'when length uses prime' do
      it { is_expected.to eq "12'" }

      context 'when length includes inches' do
        let(:length) { "12' 2\"" }

        it { is_expected.to eq "12' 2\"" }

        context 'when inches has a comma' do
          let(:length) { "12', 2\"" }

          it { is_expected.to eq "12' 2\"" }
        end
      end
    end

    context 'when length uses ft' do
      let(:length) { '12ft' }

      it { is_expected.to eq "12'" }

      context 'when length includes inches' do
        let(:length) { '12ft 2in' }

        it { is_expected.to eq "12' 2\"" }

        context 'when inches has a comma' do
          let(:length) { '12ft, 2in' }

          it { is_expected.to eq "12' 2\"" }
        end
      end
    end

    context 'when length uses feet' do
      let(:length) { '12feet' }

      it { is_expected.to eq "12'" }

      context 'when length includes inches' do
        let(:length) { '12feet 2inches' }

        it { is_expected.to eq "12' 2\"" }

        context 'when inches has a comma' do
          let(:length) { '12feet, 2inches' }

          it { is_expected.to eq "12' 2\"" }
        end
      end
    end
  end

  describe '#length_in_inches' do
    subject(:length_in_inches) { decorated_vehicle.length_in_inches }

    let(:length) { "12' 7\"" }

    it { is_expected.to eq 151 }

    context 'when there are no inches' do
      let(:length) { "12'" }

      it { is_expected.to eq 144 }
    end
  end
end
