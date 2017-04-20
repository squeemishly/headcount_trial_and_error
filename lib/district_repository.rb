require 'csv'
require 'pry'
require_relative 'district'
require_relative 'loader_module'
require_relative 'enrollment_repository'

class DistrictRepository
  include LoaderModule
  attr_reader :enrollment_repo, :districts, :data

  def initialize
    @data = nil
    @districts = []
    @enrollment_repo = nil
  end

  def load_data(path)
    @enrollment_repo = EnrollmentRepository.new #if enrollment_repo.nil?
    enrollment_repo.load_data(path, self)
  end

  def make_districts
    enrollment_repo.enrollments.each do |enrollment|
      districts << District.new({:name => enrollment.name}, self)
    end
  end

  def find_by_name(location)
    districts.find do |district|
      district.name == location
    end
  end

  def find_all_matching(fragment)
    districts.find_all do |district|
      district.name.include? fragment.upcase
    end
  end

end
