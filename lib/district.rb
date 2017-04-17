class District
  attr_reader :name,
              :dr

  def initialize(name, dr = nil)
    @name = name.values[0].upcase
    @dr = dr
  end

  def enrollment
    dr.enrollment_repo.find_by_name(name)
  end
end
