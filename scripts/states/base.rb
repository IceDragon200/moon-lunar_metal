module States
  class Base < State
    include Moon::TransitionHost

    def update(delta)
      super delta
      update_transitions delta
    end
  end
end
