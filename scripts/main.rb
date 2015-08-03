LunarMetal.config = Moon::DataLoader.file('config/settings')
LunarCache.regenerate_sub_dict
LunarMetal::System.tilesize = Moon::Vector2[LunarMetal.config.fetch_multi('tilesize.x', 'tilesize.y')]

LunarMetal.cache = Cache.new
LunarMetal.data = DataCache.new
LunarMetal.texture = TextureCache.new

module LunarMetal
  class StateManager < Moon::StateManager
    def on_spawn(state)
      state.state_manager = self
    end
  end
end

def step(engine, delta)
  @state_manager ||= begin
    LunarMetal::StateManager.new(engine).tap do |s|
      s.push States::Title
      s.push States::Splash
      s.push States::PreLoad
    end
  end
  @state_manager.step delta
end
