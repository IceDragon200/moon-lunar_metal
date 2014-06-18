class Cache < Moon::CacheBase

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

