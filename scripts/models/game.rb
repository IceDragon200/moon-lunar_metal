class Game < Moon::DataModel::Metal
  class << self
    attr_accessor :current
  end

  field :playtime,    type: Float,   default: 0.0
  field :mission,     type: Boolean, default: false
  field :skirmish,    type: Boolean, default: false
  field :teams,       type: [Team],  allow_nil: true, default: proc{[]}
  field :player_team, type: String,  default: ""
end
