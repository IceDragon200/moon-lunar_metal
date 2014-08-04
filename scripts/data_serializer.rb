module DataSerializer
  def self.resolve_references(data)
    case data
    when Array
      data.map do |obj|
        resolve_references(obj)
      end
    when Hash
      if ref = data["&ref"]
        DataLoader.file(ref)
      else
        data.each_with_object({}) do |a, r|
          k, v = *a
          r[k] = resolve_references(v)
        end
      end
    else
      data
    end
  end

  def self.load(data)
    resolved_data = resolve_references(data)
    Object.const_get(resolved_data.fetch("&class")).load(resolved_data)
  end

  def self.load_file(filename)
    load(DataLoader.file(filename))
  end

  def self.dump(obj)
    # TODO
  end

  class << self
    private :resolve_references
  end
end
