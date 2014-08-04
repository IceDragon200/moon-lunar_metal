class CombatHudView < StateView
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def update(delta)

  end

  def render(x=0, y=0, z=0)
    super x, y, z
  end
end
