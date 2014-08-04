module DataLoader
  def self.string(string)
    YAML.load(string)
  end

  def self.file(filename)
    string(File.read("data/#{filename}.yml"))
  end
end
