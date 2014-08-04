class CampaignController < StateController
  def start
    Game.current = Game.new
    Game.current.set("mission" => true, "skirmish" => false)
  end
end
