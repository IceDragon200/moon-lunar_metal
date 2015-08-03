class MapCursor < Cursor
  include Moon::Eventable
  include Moon::Activatable

  def allow_event?(event)
    active?
  end

  def post_initialize
    super
    initialize_eventable
    initialize_events
  end

  def initialize_events
    held = [:press, :repeat]

    action = [:z, :mouse_right]
    cancel = [:x]
    select = [:c, :mouse_left]

    on :mousemove_on_map do |e|
      self.position = e.map_position
      trigger :moved
    end

    on held do |e|
      case e.key
      when :left
        self.position -= [1, 0]
        trigger :moved
      when :right
        self.position += [1, 0]
        trigger :moved
      when :up
        self.position -= [0, 1]
        trigger :moved
      when :down
        self.position += [0, 1]
        trigger :moved
      end
    end

    on :press do |e|
      case e.key
      when *action
        trigger :action
      when *cancel
        trigger :cancel
      when *select
        trigger :select
      end
    end
  end
end
