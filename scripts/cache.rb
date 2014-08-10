class LunarCache < Moon::CacheBase
  @@substitution_dict = {}

  def escape_filename(filename)
    filename.gsub(/:(.*):/) { @@substitution_dict[$1] }
  end

  def self.regenerate_sub_dict
    @@substitution_dict = LunarMetal.config
  end

  private :escape_filename
end

class Cache < LunarCache
  cache def tileset(filename, cw, ch)
    filename = escape_filename(filename)
    Moon::Spritesheet.new("resources/tilesets/#{filename}", cw, ch)
  end

  cache def font(filename, size)
    filename = escape_filename(filename)
    @font_map ||= {
      "handel_gothic" => "Handel Gothic.ttf",
      "uni0553" => "uni0553/uni0553-webfont.ttf",
      "system"  => "uni0553/uni0553-webfont.ttf",
    }

    filename = @font_map[filename] || filename
    Moon::Font.new("resources/fonts/#{filename}", size)
  end
end

class TextureCache < LunarCache
  cache def tileset(filename)
    filename = escape_filename(filename)
    Moon::Texture.new("resources/tilesets/#{filename}")
  end
end

class DataCache < LunarCache
  cache def palette(*)
    PaletteParser.load_palette(DataLoader.file("palette"))
  end

  cache def armor(filename)
    DataSerializer.load_file("armors/#{filename}")
  end

  cache def building(filename)
    DataSerializer.load_file("buildings/#{filename}")
  end

  cache def faction(filename)
    DataSerializer.load_file("factions/#{filename}")
  end

  cache def look(filename)
    DataSerializer.load_file("looks/#{filename}")
  end

  cache def map(filename)
    DataSerializer.load_file("maps/#{filename}")
  end

  cache def tileset(filename)
    DataSerializer.load_file("tilesets/#{filename}")
  end

  cache def unit(filename)
    DataSerializer.load_file("units/#{filename}")
  end

  cache def weapon(filename)
    DataSerializer.load_file("weapons/#{filename}")
  end
end
