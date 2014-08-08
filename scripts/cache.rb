class Cache < Moon::CacheBase
  branch :tileset do
    lambda do |filename, cw, ch|
      Moon::Spritesheet.new("resources/tilesets/#{filename}", cw, ch)
    end
  end

  branch :font do
    loader = lambda do |filename|
      ->(fontsize) { Moon::Font.new("resources/fonts/#{filename}", fontsize) }
    end

    fonts = {}
    fonts["handel_gothic"] = loader.call("Handel Gothic.ttf")
    fonts["uni0553"] = loader.call("uni0553/uni0553-webfont.ttf")

    fonts["system"] = fonts["uni0553"]
    fonts
  end
end

class DataCache < Moon::CacheBase
  branch :palette do
    lambda do |*args|
      PaletteParser.load_palette(DataLoader.file("palette"))
    end
  end

  branch :armor do
    lambda do |filename|
      DataSerializer.load_file("armors/#{filename}")
    end
  end

  branch :building do
    lambda do |filename|
      DataSerializer.load_file("buildings/#{filename}")
    end
  end

  branch :faction do
    lambda do |filename|
      DataSerializer.load_file("factions/#{filename}")
    end
  end

  branch :look do
    lambda do |filename|
      DataSerializer.load_file("looks/#{filename}")
    end
  end

  branch :map do
    lambda do |filename|
      DataSerializer.load_file("maps/#{filename}")
    end
  end

  branch :tileset do
    lambda do |filename|
      DataSerializer.load_file("tilesets/#{filename}")
    end
  end

  branch :unit do
    lambda do |filename|
      DataSerializer.load_file("units/#{filename}")
    end
  end

  branch :weapon do
    lambda do |filename|
      DataSerializer.load_file("weapons/#{filename}")
    end
  end
end
