class StateController
  attr_reader :state
  attr_reader :state_manager

  def initialize(state)
    @state = state
    @state_manager = @state.state_manager
  end
end
