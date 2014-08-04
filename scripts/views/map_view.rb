class MapView < StateView
  attr_reader :tilemap

  def init_elements
    super
    @tilemap = Moon::Tilemap.new
  end

  def render_elements(x, y, z, options={})
    @tilemap.render(x, y, z, options)
    super x, y, z, options
  end
end

class MapViewController
  attr_reader :map

  def initialize(view)
    @view = view
  end

  def map=(map)
    @map = map
    @view.tilemap.tileset = LunarMetal.cache.tileset(@map.tileset.filename,
                                                     @map.tileset.cell_width,
                                                     @map.tileset.cell_height)
    @view.tilemap.data = @map.data
    screct = Moon::Screen.rect
    @view.tilemap.view = Moon::Cuboid.new(0, 0, 0, screct.width / @view.tilemap.tileset.cell_width, screct.width / @view.tilemap.tileset.cell_height, 1)
  end
end
