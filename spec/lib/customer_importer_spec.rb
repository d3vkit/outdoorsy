# frozen_string_literal: true

require 'fileutils'

require_relative '../../lib/customer_importer'

def read_test_file
  File.open('test.txt')
end

def write_test_file
  return File.open('test.txt') if File.exist?('test.txt')

  File.write('test.txt', 'test')
end

def delete_test_file
  File.delete('test.txt') if File.exist?('test.txt')
end

RSpec.describe CustomerImporter do
  subject(:customer_importer) { described_class.new(file_path:, col_sep:) }

  let(:file_path) { 'spec/fixtures/commas.txt' }
  let(:col_sep)   { ',' }

  after { delete_test_file }

  describe '#parse' do
    subject(:parse) { customer_importer.parse }

    it { is_expected.to be_a CustomersList }

    it 'has customer data', :aggregate_failures do
      result = parse

      expect(result.customers.first).to be_a Models::Customer
      expect(result.customers.first.name).to eq 'Greta Thunberg'
    end

    context 'when given a different column seperator' do
      let(:file_path) { 'spec/fixtures/pipes.txt' }
      let(:col_sep)   { '|' }

      it { is_expected.to be_a CustomersList }

      it 'has customer data', :aggregate_failures do
        result = parse

        expect(result.customers.first).to be_a Models::Customer
        expect(result.customers.first.name).to eq 'Ansel Adams'
      end
    end
  end
end
