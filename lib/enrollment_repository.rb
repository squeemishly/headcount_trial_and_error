require 'pry'
require 'csv'
require_relative 'loader_module'
require_relative 'enrollment'

class EnrollmentRepository
  include LoaderModule
  attr_reader :data, :enrollments

  def initialize
    @data = nil
    @enrollments = []
  end

  def load_data(path)
    csv_loader(path)
    make_enrollments
    # binding.pry
  end

  def make_enrollments
    data.each do |row|
      if find_by_name(row[:location].upcase)
        find_by_name(row[:location].upcase).school_info[:kindergarten_participation][row[:timeframe]] = row[:data]
      else
        enrollments << Enrollment.new({:name => row[:location],
         :kindergarten_participation => { row[:timeframe] => row[:data]}})
      end
      # binding.pry
    end
  end

    ### find a better enum.
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
