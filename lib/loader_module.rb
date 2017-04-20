module LoaderModule

  def read_file(file, new_key)
    CSV.open(file,headers: true, header_converters: :symbol)
  end

end
