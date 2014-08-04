class SkirmishController < StateController
  def start
    Game.current = Game.new
    Game.current.set("mission" => false, "skirmish" => true)
  end
end
