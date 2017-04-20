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
      data = read_file(value, path[:enrollment])
      make_enrollments(key, data)
      dr.make_districts if dr != nil
    end
  end

  def make_enrollments(key, data)
    # binding.pry
    data.each do |row|
      if find_by_name(row[:location].upcase)
        find_by_name(row[:location].upcase).school_info[
          key][row[:timeframe]] = row[:data]
      else
        enrollments << Enrollment.new({:name => row[:location],
         key => { row[:timeframe] => row[:data]}})
      end
    end
  end

  def find_by_name(location)
    enrollments.find do |enrollment|
      enrollment.name == location
    end
  end

  #   enrollment = nil
  #   @data.each do |row|
  #     if row[:location].upcase == location.upcase
  #       enrollment = Enrollment.new({:name => location.upcase})
  #     end
  #   end
  #   enrollment
  # end
end

# ---------------------------------------------------------------------------
# require 'pry'
#
# class EnrollmentRepository
#   attr_reader :path
#               :repo
#
#   def initialize(path, repo)
#     @path = path
#     @repo = repo
#   end
#
#   def csv
#     @csv ||= CSV.open(path[:kindergarten], headers:true, header_converters: :symbol)
#   end
#
#   def all
#     @all ||= csv.map do |row|
#       Enrollment.new(row, self)
#       # binding.pry
#     end
#   end
#   enrollment_names = {}
#   @all.each do |enrollment|
#     enrollment_names[enrollment.name] = Hash.new
#   end
#
#   @all.each do |enrollment|
#     enrollment_names[enrollment.name][enrollment.timeframe] = enrollment.data
#   end
# end
