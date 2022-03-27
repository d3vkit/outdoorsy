# frozen_string_literal: true

require 'singleton'
require_relative 'ui_manager'

module Ui
  class InputManager
    include Singleton

    YES_WORDS = %w[y yes 1 true].freeze
    NO_WORDS = %w[n no 0 false].freeze
    EXIT_WORDS = %w[q quit exit].freeze

    def self.collect_input(prepend_text = nil, default: nil)
      input = ''

      while input == ''
        print prepend_text if prepend_text
        print " (press enter to use default #{default}): " unless default.nil?

        input = gets.chomp

        break if input == '' && !default.nil?

        UiManager.write('Invalid input, please try again', color: 'red') if input == ''
      end

      UiManager.quit if EXIT_WORDS.include?(input)

      return default if input == ''

      input
    end

    def self.boolean_check(prepend_text = nil)
      input = collect_input(prepend_text).downcase

      unless (YES_WORDS + NO_WORDS).include?(input)
        UiManager.write('Invalid input, must be Y or N', 'red')

        boolean_check(prepend_text)
      end

      return true if YES_WORDS.include?(input)
      return false if NO_WORDS.include?(input)
    end
  end
end
