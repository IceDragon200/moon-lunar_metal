class MapView < StateView
  attr_reader :tilemap # Moon::Tilemap
  attr_reader :cursor  # CursorRenderer
  attr_reader :units   # RenderArray<UnitRenderer>

  def init_elements
    super
    @tilemap = Moon::Tilemap.new
    @cursor = CursorRenderer.new
    @units = RenderArray.new

    add(@tilemap)
    add(@cursor)
    add(@units)
  end
end

class MapViewController
  attr_reader :map
  attr_reader :world

  def initialize(view)
    @view = view
    @camera_view = Moon::Vector2.new
    @cursor_position = Moon::Vector2.new
    @tilesize = Moon::Vector2.new
  end

  def update_map_view
    pos = ((@cursor_position * @tilesize) - @camera_view).xyz
    campos = -@camera_view.xyz
    @view.cursor.position = pos
    @view.tilemap.position = campos
    @view.units.position = campos
  end

  def map=(map)
    @map = map
    filename = @map.tileset.filename
    if @map.tileset.cell_sizes?
      cw, ch = @map.tileset.cell_width, @map.tileset.cell_height
    elsif @map.tileset.table?
      t = LunarMetal.texture.tileset(filename)
      cw, ch = t.width / @map.tileset.cols, t.height / @map.tileset.rows
    else
      raise "@map.tileset was neither cellular nor tabular"
    end
    @view.tilemap.tileset = LunarMetal.cache.tileset(filename, cw, ch)
    @tilesize = Moon::Vector2[cw, ch]
    @view.tilemap.data = @map.data
    screct = Moon::Screen.rect
    @view.tilemap.view = Moon::Rect.new(-@tilesize.x, -@tilesize.y, screct.width + @tilesize.x, screct.height + @tilesize.y)
  end

  def world=(world)
    @world = world
    self.map = @world.map

    refresh_units
  end

  def cursor_position=(cursor_position)
    @cursor_position = cursor_position
    update_map_view
  end

  def camera_view=(v2)
    @camera_view = v2
    update_map_view
  end

  def refresh_units
    @view.units.clear
    @world.units.each do |unit|
      add_unit(unit)
    end
  end

  def add_unit(unit)
    @view.units << (UnitRenderer.new.tap { |r| r.unit = unit })
  end

  def remove_unit(unit)
    @view.units.reject! { |u| u.unit == unit }
  end
end
