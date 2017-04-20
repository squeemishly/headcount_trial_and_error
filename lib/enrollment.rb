class Enrollment
  attr_reader :school_info,
              :name

  def initialize(school_info)
    @name = school_info[:name].upcase
    @school_info = school_info
  end

  def kindergarten_participation_by_year
    numberize_values(kindergarten)
  end

  def kindergarten_participation_in_year(year)
    numberize_values(kindergarten)[year]
  end

  def graduation_rate_by_year
    numberize_values(high_school)
  end

  def graduation_rate_in_year(year)
    numberize_values(high_school)[year]
  end

  def numberize_values(data)
    Hash[data.keys.map(&:to_i).zip(data.values.map {|x| x.to_f.round(3)})]
  end

  def kindergarten
    school_info[:kindergarten_participation] || school_info[:kindergarten]
  end

  def high_school
    school_info[:high_school_graduation]
  end

end
