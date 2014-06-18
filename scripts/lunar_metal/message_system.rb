class MessageSystem

  def initialize
    @listeners = []
  end

  def send(message, options={})
    @listeners.each do |listener|
      listener.receive(message, options)
    end
  end

end
