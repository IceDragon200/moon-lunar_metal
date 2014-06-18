class Position
  include Moon::Component

  field :x, type: Integer, default: 0
  field :y, type: Integer, default: 0
end

class Armor
  include Moon::Component

  field :value, type: Integer, default: 0
  field :max, type: Integer, default: 0
end

class Shield
  include Moon::Component

  field :value, type: Integer, default: 0
  field :max, type: Integer, default: 0
end

class Weapon
  include Moon::Component

  field :atk, type: Integer, default: 0
  field :range, type: Integer, default: 0
end

class Direction
  include Moon::Component

  field :dir, type: Integer, default: 0
end

class SpriteSettings
  include Moon::Component

  field :index, type: Integer, default: 0
  field :filename, type: String, default: ""
end
