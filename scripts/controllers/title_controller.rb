class TitleController < StateController
  def campaign
    state_manager.push(States::Campaign)
  end

  def skirmish
    state_manager.push(States::Skirmish)
  end

  def load_game
    state_manager.push(States::LoadGame)
  end

  def options
    state_manager.push(States::Options)
  end

  def map
    state_manager.push(States::Map)
  end

  def unit_viewer
    state_manager.push(States::UnitViewer)
  end

  def quit
    state.engine.quit
  end
end
