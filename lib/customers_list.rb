# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/array/wrap'

class CustomersList
  attr_reader :customers

  def initialize(customers = [])
    @customers = Array.wrap(customers)
  end

  def show
    print_headers

    customers.each do |customer|
      print "\n"
      print "#{customer.name} | #{customer.email} | #{customer.vehicle_type} | #{customer.vehicle_name} |"
      print " #{customer.vehicle_length}"
    end
  end

  private

  def print_headers
    print headers.join(' | ')
  end

  def headers
    ['Name', 'Email', 'Vehicle Type', 'Vehicle Name', 'Vehicle Length']
  end
end
