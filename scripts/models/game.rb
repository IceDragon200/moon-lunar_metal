class Game < Moon::DataModel::Metal
  class << self
    attr_accessor :current
  end

  field :playtime,    type: Float,     default: 0.0
  field :mission,     type: Boolean,   default: false
  field :skirmish,    type: Boolean,   default: false
  field :teams,       type: [Team],    default: proc{[]}
  field :player_team, type: String,    default: ""
  field :units,       type: [Unit],    default: proc{[]}
  field :cursor,      type: MapCursor, default: proc{|t|t.new}
  field :camera,      type: Camera,    default: proc{|t|t.new}

  def update(delta)
    camera.update(delta)
  end
end
