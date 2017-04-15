# require 'csv'
# require 'pry'
# require_relative 'district'
# require_relative 'loader_module'
# require_relative 'enrollment_repository'
#
# class DistrictRepository
#   include LoaderModule
#   attr_reader :csv, :enrollment_repository, :districts
#
#   def initialize
#     @csv = nil
#     @districts = []
#     @enrollment_repository = EnrollmentRepository.new
#   end
#
#   def load_data(path)
#     new_key = path[path.keys[0]]
#     @csv ||= CSV.open(path[path.keys[0]][new_key.keys[0]], headers: true, header_converters: :symbol)
#     csv.each do |row|
#       districts << row[:location]
#     end
#     districts.uniq!
#     districts.map! do |district|
#       district = District.new({:name => district.upcase})
#     end
#     enrollment_repository.load_data(path)
#   end
#
#   ### find a better enum.
#   def find_by_name(location)
#     answer = nil
#     districts.each do |district|
#       if district.name == location
#         answer = district.name
#       end
#     end
#     answer
#   end
#
#   ### find a better enum. (maybe make a method that gives an array of just district names?)
#   def find_all_matching(fragment)
#     locations = []
#     districts.each do |district|
#       if district.name.include? fragment.upcase
#         locations << district.name
#       end
#     end
#     locations
#   end
# end
#
# ----------------------------------------------------------------------
require 'pry'
require 'csv'
require_relative 'enrollment_repository'
require_relative 'enrollment'

class DistrictRepository
  attr_reader :enrollment

  def initialize(data)
    @enrollment ||= EnrollmentRepository.new(data[:enrollment], self)
      binding.pry
  end

  def self.from_csv(data)
    DistrictRepository.new(data)
  end
end
