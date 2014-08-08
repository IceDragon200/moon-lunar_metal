class MapView < StateView
  attr_reader :tilemap
  attr_reader :cursor

  def init_elements
    super
    @tilemap = Moon::Tilemap.new
    @cursor = CursorRenderer.new

    add(@tilemap)
    add(@cursor)
  end
end

class MapViewController
  attr_reader :map

  def initialize(view)
    @view = view
    @camera_view = Moon::Vector2.new
    @cursor_position = Moon::Vector2.new
    @tilesize = Moon::Vector2.new
  end

  def update_map_view
    pos = ((@cursor_position * @tilesize) - @camera_view).xyz
    @view.cursor.position = pos
    @view.tilemap.position = -@camera_view.xyz
  end

  def map=(map)
    @map = map
    @view.tilemap.tileset = LunarMetal.cache.tileset(@map.tileset.filename,
                                                     @map.tileset.cell_width,
                                                     @map.tileset.cell_height)
    @tilesize = Moon::Vector2[@view.tilemap.tileset.cell_width,
                              @view.tilemap.tileset.cell_height]
    @view.tilemap.data = @map.data
    screct = Moon::Screen.rect
    @view.tilemap.view = Moon::Rect.new(-@tilesize.x, -@tilesize.y, screct.width + @tilesize.x, screct.height + @tilesize.y)
  end

  def cursor_position=(cursor_position)
    @cursor_position = cursor_position
    update_map_view
  end

  def camera_view=(v2)
    @camera_view = v2
    update_map_view
  end
end
