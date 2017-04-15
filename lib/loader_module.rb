module LoaderModule

  def csv_loader(path)
    new_key = path[path.keys[0]]
    @data ||= CSV.open(path[path.keys[0]][new_key.keys[0]],
    headers: true, header_converters: :symbol)
  end

end
