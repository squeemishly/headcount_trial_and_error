# require 'pry'
# require 'csv'
# require_relative 'loader_module'
# require_relative 'enrollment'
#
# class EnrollmentRepository
#   include LoaderModule
#   attr_reader :file, :data
#
#   def initialize
#     @data = nil
#   end
#
#   def load_data(path)
#     array = []
#     new_key = path[path.keys[0]]
#     @data = CSV.open(path[path.keys[0]][new_key.keys[0]], headers: true, header_converters: :symbol)
#     @data.each do |row|
#       array << row
#     end
#     array.map! do |row|
#       row = Enrollment.new({:name => row[:location], :school_participation => { row[:timeframe] => row[:data]}})
#     end
#     binding.pry
#   end
#
#     ### find a better enum.
#   def find_by_name(location)
#     enrollment = nil
#     @data.each do |row|
#       if row[:location].upcase == location.upcase
#         enrollment = Enrollment.new({:name => location.upcase})
#       end
#     end
#     enrollment
#   end
# end
#
# ---------------------------------------------------------------------------
require 'pry'

class EnrollmentRepository
  attr_reader :path
              :repo

  def initialize(path, repo)
    @path = path
    @repo = repo
  end

  def csv
    @csv ||= CSV.open(path[:kindergarten], headers:true, header_converters: :symbol)
  end

  def all
    @all ||= csv.map do |row|
      Enrollment.new(row, self)
      # binding.pry
    end
  end
  enrollment_names = {}
  @all.each do |enrollment|
    enrollment_names[enrollment.name] = Hash.new
  end

  @all.each do |enrollment|
    enrollment_names[enrollment.name][enrollment.timeframe] = enrollment.data
  end
end
