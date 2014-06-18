Moon::Screen.resize 640, 480
module LunarMetal
  class << self
    attr_accessor :cache
  end
end

require "scripts/lunar_metal"

LunarMetal::Game.current = LunarMetal::Game.new
LunarMetal.cache = Cache.new

State.push States::Title
State.push States::Splash
