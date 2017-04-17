module LoaderModule

  def enrollment_loader(path, dr)
    new_key = path[:enrollment]
    new_key.each do |key, value|
      @data = read_file(value, new_key)
      make_enrollments(key)
      dr.make_districts if dr != nil
    end
  end

  def read_file(file, new_key)
    CSV.open(file,headers: true, header_converters: :symbol)
  end



end
