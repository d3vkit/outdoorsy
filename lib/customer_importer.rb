# frozen_string_literal: true

require 'active_support'

class CustomerImporter
  def initialize(file_path: '', file: nil)
    validate_input(file_path, file)

    @file_path = file_path
    @file = file
  end

  def file
    @file ||= File.open(@file_path)
  end

  private

  def validate_input(file_path, file)
    raise ArgumentError, 'Must provide either file path or file!' if file_path.blank? && file.nil?
    raise ArgumentError, 'Must provide only file path or file!' if file_path.present? && file.present?
  end
end
