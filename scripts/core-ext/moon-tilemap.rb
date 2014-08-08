module Moon
  class Tilemap
    include Containable

    alias :initialize_wo_events :initialize
    def initialize(*args, &block)
      init_eventable
      initialize_wo_events(*args, &block)
    end
  end
end
