class UnitViewerView < StateView
  attr_reader :name_text
  attr_reader :unit_render
  attr_reader :unit

  @@default_mapping = Moon::Table.new(1, 1, default: 1)

  def init_events
    super

    on :unit_direction_change do
      if @unit.traits.key?("mapping")
        @mapping_render.mapping = @unit.traits["mapping"].mappings[@unit.direction]
      else
        @mapping_render.mapping = @@default_mapping
      end
    end
  end

  def refresh_unit
    @name_text.string = ""
    @unit_render.visual_info = nil
    @mapping_render.mapping = nil
    return unless @unit
    @unit_render.unit = @unit
    if tt = @unit.traits["tooltip"]
      @name_text.string = tt["name"].to_s
    end

    @name_text.position.x = (@unit_background.cell_width - @name_text.width) / 2
    @unit_render.position.x = (@unit_background.cell_width - @unit_render.width) / 2
    @unit_render.position.y = (@unit_background.cell_height - @unit_render.height) / 2
    @mapping_render.position.set(@unit_background.cell_width, 0, 0)
  end

  def init_elements
    @unit_background = Moon::Spritesheet.new("resources/ui/gauge_512x512_transparent.png", 512, 512)
    @name_text = Moon::Text.new("", LunarMetal.cache.font("system", 16))
    @unit_render = UnitRenderer.new
    @mapping_render = MappingCursorRenderer.new

    add(@name_text)
    add(@unit_render)
    add(@mapping_render)
  end

  def unit=(unit)
    @unit = unit

    refresh_unit
  end

  def render_elements(x, y, z, options)
    @unit_background.render(x, y, z, 5)
    super
  end
end
