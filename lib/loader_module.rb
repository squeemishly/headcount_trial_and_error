module LoaderModule

  def read_file(file)
    CSV.open(file,headers: true, header_converters: :symbol)
  end

end
