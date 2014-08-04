class TitleController < StateController
  def campaign
    State.change(States::Campaign)
  end

  def skirmish
    State.change(States::Skirmish)
  end

  def load_game
    State.change(States::LoadGame)
  end

  def options
    State.change(States::Options)
  end

  def quit
    exit
  end
end
