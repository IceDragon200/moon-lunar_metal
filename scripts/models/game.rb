class Game < Moon::DataModel::Metal
  class << self
    attr_accessor :current
  end

  field :playtime,    type: Float,       default: 0.0
  field :mission,     type: Boolean,     default: false
  field :skirmish,    type: Boolean,     default: false

  field :world,       type: World,       default: nil

  def update(delta)
    world.update(delta)
  end
end
