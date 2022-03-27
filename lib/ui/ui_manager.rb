# frozen_string_literal: true

require 'singleton'

require_relative 'text_manager'
require_relative 'input_manager'

module Ui
  class UiManager
    include Singleton

    def self.set_proc_title
      $0 = 'Outdoor.sy Customer List Tool'
      Process.setproctitle('Outdoor.sy Customer List Tool')
      system("printf \"\033]0;Outdoor.sy Customer List Tool\007\"")
    end

    def self.clear_screen
      return if ENV['DEBUG']

      system 'clear'
    end

    def self.write(text, color: nil)
      text = TextManager.public_send(color, text) if color

      puts text
    end

    def self.line_break
      puts '-' * 50
    end

    def self.collect_input(prepend_text = nil, default: nil)
      InputManager.collect_input(prepend_text, default:)
    end

    def self.boolean_check(prepend_text = nil)
      InputManager.boolean_check(prepend_text)
    end

    def self.quit
      write('Thank you!', color: 'green')

      exit(true)
    end

    def self.wait
      write('Press any key to continue')

      gets.chomp
    end

    def self.write_errors(message)
      write(message)
      wait
    end
  end
end
