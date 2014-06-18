class Cache < Moon::CacheBase

  branch :palette do
    lambda do |*args|
      Aach.load_palette(YAML.load(File.read("data/palette.yml")))
    end
  end

  branch :tileset do
    lambda do |filename, *args|
      Moon::Spritesheet.new "resources/tilesets/#{filename}", *args
    end
  end

  branch :font do
    loader = lambda do |filename|
      ->(fontsize) { Moon::Font.new("resources/fonts/#{filename}", fontsize) }
    end

    fonts = {}
    fonts["handel_gothic"] = loader.("Handel Gothic.ttf")
    fonts
  end

end

