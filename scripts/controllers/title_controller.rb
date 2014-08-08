class TitleController < StateController
  def campaign
    State.push(States::Campaign)
  end

  def skirmish
    State.push(States::Skirmish)
  end

  def load_game
    State.push(States::LoadGame)
  end

  def options
    State.push(States::Options)
  end

  def map
    State.push(States::Map)
  end

  def unit_viewer
    State.push(States::UnitViewer)
  end

  def quit
    exit
  end
end
