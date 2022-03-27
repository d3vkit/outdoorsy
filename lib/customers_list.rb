# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/array/wrap'

class CustomersList
  attr_reader :customers

  def initialize(customers = [])
    @customers = Array.wrap(customers)
  end

  def show(sort = :name)

  end
end
