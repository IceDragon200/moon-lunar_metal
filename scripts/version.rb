#Moon::Screen.resize 640, 480
module LunarMetal
  module Version
    MAJOR, MINOR, TEENY, PATCH = 0, 0, 1, nil
    STRING = [MAJOR, MINOR, TEENY, PATCH].compact.join('.')
  end
  VERSION = Version::STRING

  module System
    class << self
      attr_accessor :tilesize
    end
  end

  class << self
    attr_accessor :cache
    attr_accessor :data
    attr_accessor :texture
    attr_accessor :config
  end
end
