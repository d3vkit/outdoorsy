# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/array/wrap'

require_relative 'decorators/customer_decorator'

class CustomersList
  attr_reader :customers

  SORT_TYPES = %i[none name first_name last_name email vehicle_type vehicle_name vehicle_length_in_inches].freeze
  SORT_DIRS = %i[asc desc].freeze

  def initialize(customers = [])
    customers = Array.wrap(customers)
    @customers = Decorators::CustomerDecorator.from_collection(customers)
  end

  def show(sort: :none, dir: :asc)
    print_headers
    sorted_customers = sort(type: sort, dir:)
    sorted_customers.each { |customer| print "\n#{customer}" }

    nil
  end

  def sort(type:, dir:)
    type = type.to_sym
    dir = dir.to_sym

    validate_sort(type, dir)

    new_customers = sort_customers(type)
    new_customers.reverse! if dir == :desc

    new_customers
  end

  private

  def sort_customers(type)
    return customers if type == :none

    customers.sort_by do |customer|
      value = customer.public_send(type)
      value = value.downcase if value.is_a?(String)
      value
    end
  end

  def print_headers
    print headers.join(' | ')
  end

  def headers
    ['Name', 'Email', 'Vehicle Type', 'Vehicle Name', 'Vehicle Length in Inches']
  end

  def validate_sort(type, dir)
    raise ArgumentError, "Invalid sort type, given #{type}" unless SORT_TYPES.include?(type)
    raise ArgumentError, "Invalid sort dir, given #{dir}" unless SORT_DIRS.include?(dir)
  end
end
