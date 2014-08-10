class UnitSpritesheetInfo < SpritesheetInfo
  field :frames,      type: {String=>Array},  default: proc{{}}
end

class SpriteInfo < Moon::DataModel::Metal
end

class VisualInfo < Moon::DataModel::Metal
  field :spritesheet, type: SpritesheetInfo, allow_nil: true, default: nil
  field :sprite,      type: SpriteInfo,      allow_nil: true, default: nil
end
