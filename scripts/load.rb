#Moon::Screen.resize 640, 480
module LunarMetal
  VERSION = '0.0.1'

  class << self
    attr_accessor :cache
    attr_accessor :data
    attr_accessor :texture
  end
end

require 'scripts/mixins'
require 'scripts/core-ext'
require 'scripts/data_loader'
require 'scripts/data_serializer'
require 'scripts/cache'
require 'scripts/entity_system'
require 'scripts/message_system'
require 'scripts/renderers'
require 'scripts/views'
require 'scripts/models'
require 'scripts/controllers'
require 'scripts/states'
require 'scripts/act_interpreter'

LunarMetal.cache = Cache.new
LunarMetal.data = DataCache.new
LunarMetal.texture = TextureCache.new

State.push States::Title
State.push States::Splash
State.push States::PreLoad
