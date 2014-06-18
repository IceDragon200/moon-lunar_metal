class CombatWorldView < Moon::RenderContainer

  attr_accessor :game

  def initialize(game)
    @game = game
    @tilemap = Moon::Tilemap.new
  end

  def update(delta)
    #
  end

  def render(x, y, z)
    @tilemap.render(x, y, z)
    #
  end

end
