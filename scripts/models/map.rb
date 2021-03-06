class Map < Moon::DataModel::Base
  field :data,     type: Moon::DataMatrix, allow_nil: true, default: nil
  field :passages, type: Moon::Table,      allow_nil: true, default: nil
  field :terrain,  type: Moon::Table,      allow_nil: true, default: nil
  field :tileset,  type: Tileset,          allow_nil: true, default: nil

  def width
    data.xsize
  end

  def height
    data.ysize
  end

  def depth
    data.zsize
  end
end
