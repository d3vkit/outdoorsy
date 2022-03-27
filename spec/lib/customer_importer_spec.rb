# frozen_string_literal: true

require_relative '../../lib/customer_importer'

RSpec.describe CustomerImporter do
  subject(:customer_importer) { described_class.new(file_path:, col_sep:) }

  let(:file_path) { 'spec/fixtures/commas.txt' }
  let(:col_sep)   { ',' }

  describe '#parse' do
    subject(:parse) { customer_importer.parse }

    it { is_expected.to be_a CustomersList }

    it 'has customer data', :aggregate_failures do
      result = parse

      expect(result.customers.first).to be_a Decorators::CustomerDecorator
      expect(result.customers.first.name).to eq 'Greta Thunberg'
    end

    context 'when given a different column seperator' do
      let(:file_path) { 'spec/fixtures/pipes.txt' }
      let(:col_sep)   { '|' }

      it { is_expected.to be_a CustomersList }

      it 'has customer data', :aggregate_failures do
        result = parse

        expect(result.customers.first).to be_a Decorators::CustomerDecorator
        expect(result.customers.first.name).to eq 'Ansel Adams'
      end
    end
  end
end
