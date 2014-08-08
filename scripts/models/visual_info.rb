class SpritesheetInfo < Moon::DataModel::Metal
  field :filename,    type: String,  default: ""
  field :cell_width,  type: Integer, default: 32
  field :cell_height, type: Integer, default: 32
  field :frames,      type: {String=>Array},  default: proc{{}}
end

class SpriteInfo < Moon::DataModel::Metal
end

class VisualInfo < Moon::DataModel::Metal
  field :spritesheet, type: SpritesheetInfo, allow_nil: true, default: nil
  field :sprite,      type: SpriteInfo,      allow_nil: true, default: nil
end
