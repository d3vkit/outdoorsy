# frozen_string_literal: true

require 'active_support'
require 'csv'

require_relative 'customers_list'
require_relative 'customer_builder'
require_relative 'decorators/customer_decorator'
require_relative 'models/customer'
require_relative 'models/vehicle'

class CustomerImporter
  attr_reader :col_sep, :customers_list

  alias customers customers_list

  def initialize(file_path:, col_sep: ',')
    raise ArgumentError, 'File must exist!' unless File.exist?(file_path)

    @file_path = file_path
    @col_sep = col_sep
    @customers_list = CustomersList.new
  end

  def parse
    @parse ||= begin
      File.open(@file_path) do |file|
        CSV.foreach(file, col_sep:) do |row|
          customer = CustomerBuilder.from_row(row)
          @customers_list.customers << Decorators::CustomerDecorator.new(customer)
        end
      end

      @customers_list
    end
  end
end
