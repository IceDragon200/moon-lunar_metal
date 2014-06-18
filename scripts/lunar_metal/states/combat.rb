module States
  class Combat < Base

    def init
      @game = LunarMetal::Game.current
      @hud = CombatHudView.new @game
      @world_view = CombatWorldView.new @game
      super
    end

    def update(delta)
      @game.update(delta)
      @hud.update(delta)
      super
    end

    def render
      super
      @hud.render
    end

  end
end
