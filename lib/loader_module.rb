module LoaderModule

  def enrollment_loader(path, dr)
    path[:enrollment].each do |key, value|
      data = read_file(value, path[:enrollment])
      make_enrollments(key, data)
      dr.make_districts if dr != nil
    end
  end

  def read_file(file, new_key)
    CSV.open(file,headers: true, header_converters: :symbol)
  end



end
