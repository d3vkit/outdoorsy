# frozen_string_literal: true

require_relative 'models/customer'
require_relative 'models/vehicle'

class CustomerBuilder
  def self.from_row(row)
    vehicle = Models::Vehicle.new(type: row[3], name: row[4], length: row[5])

    Models::Customer.new(first_name: row[0], last_name: row[1], email: row[2], vehicle:)
  end
end
