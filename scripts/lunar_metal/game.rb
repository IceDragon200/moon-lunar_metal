class LunarMetal::Game

  attr_reader :world

  def initialize
    @world = LunarMetal::World.new
  end

  def update(delta)
  end

end
