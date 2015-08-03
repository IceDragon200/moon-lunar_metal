require 'std/palette_parser'

class LunarCache < Moon::CacheBase
  @@substitution_dict = {}

  def escape_filename(filename)
    filename.gsub(/:(.+):/) { @@substitution_dict[$1] }
  end

  def self.regenerate_sub_dict
    @@substitution_dict = LunarMetal.config
  end

  private :escape_filename
end

class Cache < LunarCache
  cache def tileset(filename, cw, ch)
    filename = escape_filename(filename)
    puts "Loading Tileset: #{filename} [#{cw}, #{ch}]"
    texture = LunarMetal.texture.tileset(filename)
    Moon::Spritesheet.new(texture, cw, ch)
  end

  cache def font(filename, size)
    filename = escape_filename(filename)
    @font_map ||= {
      'handel_gothic' => 'Handel Gothic.ttf',
      'uni0553' => 'uni0553/uni0553-webfont.ttf',
      'system'  => 'uni0553/uni0553-webfont.ttf',
    }

    filename = @font_map[filename] || filename
    Moon::Font.new("resources/fonts/#{filename}", size)
  end
end

class TextureCache < LunarCache
  private def load_texture(filename)
    filename = escape_filename(filename)
    Moon::Texture.new("resources/#{filename}")
  end

  cache def resource(filename)
    load_texture(filename)
  end

  cache def tileset(filename)
    load_texture("tilesets/#{filename}")
  end

  cache def ui(filename)
    load_texture("ui/#{filename}")
  end
end

class DataCache < LunarCache
  def serializer
    Moon::DataSerializer
  end

  cache def palette(*)
    Moon::PaletteParser.load_palette(Moon::DataLoader.file('palette'))
  end

  cache def armor(filename)
    serializer.load_file("armors/#{filename}")
  end

  cache def building(filename)
    serializer.load_file("buildings/#{filename}")
  end

  cache def faction(filename)
    serializer.load_file("factions/#{filename}")
  end

  cache def look(filename)
    serializer.load_file("looks/#{filename}")
  end

  cache def map(filename)
    serializer.load_file("maps/#{filename}")
  end

  cache def tileset(filename)
    serializer.load_file("tilesets/#{filename}")
  end

  cache def unit(filename)
    serializer.load_file("units/#{filename}")
  end

  cache def weapon(filename)
    serializer.load_file("weapons/#{filename}")
  end
end
