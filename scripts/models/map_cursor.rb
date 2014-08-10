class MapCursor < Cursor
  include Moon::Eventable
  include Moon::Activatable

  def allow_event?(event)
    active?
  end

  def post_init
    super
    init_eventable
    init_events
  end

  def init_events
    alias_event(:held, :repeat)
    alias_event(:held, :press)

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
