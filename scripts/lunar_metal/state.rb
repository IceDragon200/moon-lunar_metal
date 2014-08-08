class LunarMetal::StateGame < State

  def init
    @game = LunarMetal::Game.new
    @hud = LunarMetal::Hud.new @game
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
