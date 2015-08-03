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

    action = :z
    cancel = :x

    on :held, :left do
      self.position -= [1, 0]
      trigger :moved
    end

    on :held, :right do
      self.position += [1, 0]
      trigger :moved
    end

    on :held, :up do
      self.position -= [0, 1]
      trigger :moved
    end

    on :held, :down do
      self.position += [0, 1]
      trigger :moved
    end

    on :press, action do
      trigger :action
    end

    on :press, cancel do
      trigger :cancel
    end
  end
end
