require 'pry'
require_relative 'loader_module'
require_relative 'enrollment'

class EnrollmentRepository
  include LoaderModule
  attr_reader :enrollments

  def initialize
    @enrollments = []
  end

  def load_data(path, dr = nil)
    enrollment_loader(path, dr)
  end

  def enrollment_loader(path, dr)
    path[:enrollment].each do |key, value|
      data = read_file(value)
      make_enrollments(key, data)
      dr.make_districts if dr != nil
    end
  end

  def make_enrollments(key, data)
    data.each do |row|
      enrollment = find_by_name(row[:location].upcase)
      if enrollment
        add_to_enrollment(row, key, enrollment)
      else
        create_enrollment(row, key)
      end
    end
  end

  def find_by_name(location)
    enrollments.find do |enrollment|
      enrollment.name == location
    end
  end

  def create_enrollment(row, key)
    enrollments << Enrollment.new({:name => row[:location],
      key => { row[:timeframe].to_i => row[:data].to_f }})
  end

  def add_to_enrollment(row, key, enrollment)
    if enrollment.school_info[key] == nil
      enrollment.school_info[key] = {row[:timeframe].to_i => row[:data].to_f}
    else
      enrollment.school_info[key][row[:timeframe].to_i] = row[:data].to_f
    end
  end

end
