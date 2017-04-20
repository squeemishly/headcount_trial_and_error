require 'pry'
require_relative 'district'
require_relative 'enrollment_repository'

class DistrictRepository
  attr_reader :enrollment_repo,
              :districts,
              :data

  def initialize
    @districts = []
    @enrollment_repo = EnrollmentRepository.new
  end

  def load_data(path)
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
