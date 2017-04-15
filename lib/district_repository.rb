require 'csv'
require 'pry'
require_relative 'district'
require_relative 'loader_module'
require_relative 'enrollment_repository'

class DistrictRepository
  include LoaderModule
  attr_reader :enrollment_repository, :districts, :data

  def initialize
    @data = nil
    @districts = []
    @enrollment_repository = EnrollmentRepository.new
  end

  def load_data(path)
    csv_loader(path)
    fill_list
    build_districts
    enrollment_repository.load_data(path)
  end

  def build_districts
    districts.map! do |district|
      district = District.new({:name => district})
    end
  end

  def fill_list
    data.each do |row|
      districts << row[:location]
    end
    districts.uniq!
  end

  ### find a better enum.
  def find_by_name(location)
    ### why doesn't this work here but it does in pry?
    # place = districts.find do |district|
    #   district.name == location
    # end
    # place.name
    answer = nil
    districts.each do |district|
      if district.name == location
        answer = district.name
      end
    end
    answer
  end

  ### find a better enum. (maybe make a method that gives an array of just district names?)
  def find_all_matching(fragment)
    locations = []
    districts.each do |district|
      if district.name.include? fragment.upcase
        locations << district.name
      end
    end
    locations
  end
end

# ----------------------------------------------------------------------
# require 'pry'
# require 'csv'
# require_relative 'enrollment_repository'
# require_relative 'enrollment'
#
# class DistrictRepository
#   attr_reader :enrollment
#
#   def initialize(data)
#     @enrollment ||= EnrollmentRepository.new(data[:enrollment], self)
#       binding.pry
#   end
#
#   def self.from_csv(data)
#     DistrictRepository.new(data)
#   end
# end
