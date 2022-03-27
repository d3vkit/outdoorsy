# frozen_string_literal: true

require_relative 'ui_manager'
require_relative '../customer_importer'
require_relative '../customers_list'

module Ui
  class Console
    attr_reader :file_path, :col_sep

    def initialize
      UiManager.set_proc_title

      @file_path = ''
      @col_sep = ','

      intro
    end

    private

    def intro
      UiManager.clear_screen
      UiManager.write('### CUSTOMER LIST TOOL ###')
      UiManager.line_break

      setup
    end

    def check_setup_input(new_file_path, new_col_sep)
      UiManager.clear_screen
      UiManager.write("File Path: #{new_file_path}\nColumn Separator: #{new_col_sep}")
      UiManager.line_break

      UiManager.boolean_check('Is this correct? Y/N: ')
    end

    def setup
      new_file_path = UiManager.collect_input('Path of file to parse: ', default: 'tmp/commas.txt')
      new_col_sep = UiManager.collect_input('Column Separator', default: ',')

      correct = check_setup_input(new_file_path, new_col_sep)

      setup unless correct

      @file_path = new_file_path
      @col_sep = new_col_sep

      import
    rescue ArgumentError, Errno::EISDIR => e
      write_errors(e) { intro }
    end

    def import
      list = CustomerImporter.new(file_path:, col_sep:)
      customers = list.parse

      UiManager.clear_screen

      show(customers)
    end

    def print_sort_columns
      UiManager.write("\n")
      UiManager.line_break
      UiManager.write("Sort columns: #{CustomersList::SORT_TYPES.join(', ')}")
      UiManager.line_break
    end

    def show(customers, sort: :none, dir: :asc)
      customers.show(sort:, dir:)

      print_sort_columns

      new_sort = UiManager.collect_input('Sort results on column', default: 'none')

      UiManager.write("Sort direction: #{CustomersList::SORT_DIRS.join(', ')}")
      UiManager.line_break

      new_dir = UiManager.collect_input('Sort results direction', default: 'asc')

      show(customers, sort: new_sort, dir: new_dir)
    rescue ArgumentError => e
      write_errors(e) { show(customers, sort: :none, dir: :asc) }
    end

    def write_errors(error, &block)
      UiManager.line_break
      UiManager.write_errors(error.message)

      block.call
    end
  end
end
