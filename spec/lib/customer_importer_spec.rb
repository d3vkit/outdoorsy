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
  subject(:customer_importer) { described_class.new(file_path:, file: local_file) }

  let(:file_path)  { '' }
  let(:local_file) { nil }

  after { delete_test_file }

  describe '#initialize' do
    context 'when neither file path nor file arguments are given' do
      it 'raises an ArgumentError' do
        expect { customer_importer }.to raise_error(ArgumentError, 'Must provide either file path or file!')
      end
    end

    context 'when both file path and file arguments are given' do
      let(:file_path)  { 'file.txt' }
      let(:local_file) { read_test_file }

      before { write_test_file }

      it 'raises an ArgumentError' do
        expect { customer_importer }.to raise_error(ArgumentError, 'Must provide only file path or file!')
      end
    end

    context 'when file does not exists at given file path' do
      let(:file_path) { 'my-file.txt' }

      it 'raises an ArgumentError' do
        expect { customer_importer }.to raise_error(ArgumentError, 'File must exist at given file path!')
      end
    end

    context 'when file given is not a File' do
      let(:local_file) { 'string' }

      it 'raises an ArgumentError' do
        expect { customer_importer }.to raise_error(ArgumentError, 'File must be a real file!')
      end
    end
  end

  describe '#file' do
    subject(:file) { customer_importer.file }

    context 'when file path argument is given' do
      let(:file_path)   { 'test.txt' }
      let(:loaded_file) { read_test_file }
      let(:comparison)  { FileUtils.compare_file(file, read_test_file) }

      before { write_test_file }

      it 'loads the file using the path' do
        expect(comparison).to eq true
      end
    end

    context 'when file argument is given' do
      let(:local_file) { read_test_file }

      before { write_test_file }

      it { is_expected.to eq local_file }
    end
  end
end
