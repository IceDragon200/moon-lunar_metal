#Moon::Screen.resize 640, 480
module LunarMetal
  class << self
    attr_accessor :cache
    attr_accessor :data
  end
end

require "scripts/core-ext"
require "scripts/data_loader"
require "scripts/data_serializer"
require "scripts/lunar_metal"

LunarMetal.cache = Cache.new
LunarMetal.data = DataCache.new

#State.push States::Title
State.push States::Map
State.push States::Splash
