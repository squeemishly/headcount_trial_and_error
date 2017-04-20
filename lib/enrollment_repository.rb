require 'pry'
require 'csv'
require_relative 'loader_module'
require_relative 'enrollment'
require_relative 'district_repository'

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
      if find_by_name(row[:location].upcase)
        if find_by_name(row[:location].upcase).school_info[key] == nil
          find_by_name(row[:location].upcase).school_info[
            key] = {row[:timeframe].to_i => row[:data]}
        else
          find_by_name(row[:location].upcase).school_info[
            key][row[:timeframe].to_i] = row[:data]
        end
      else
        enrollments << Enrollment.new({:name => row[:location],
         key => { row[:timeframe].to_i => row[:data] }})
      end
    end
  end

  def find_by_name(location)
    enrollments.find do |enrollment|
      enrollment.name == location
    end
  end

end
