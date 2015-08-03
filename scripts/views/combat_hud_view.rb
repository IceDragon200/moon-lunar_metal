class CombatHudView < State::ViewBase
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def update(delta)
    super
  end
end
