# frozen_string_literal: true

require 'delegate'

module Decorators
  class BaseDecorator < SimpleDelegator
    def self.from_collection(collection)
      collection.map { |item| new(item) }
    end
  end
end
