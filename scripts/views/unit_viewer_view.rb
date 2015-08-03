class UnitViewerView < StateView
  attr_reader :name_text
  attr_reader :unit_render
  attr_reader :unit

  @@default_mapping = Moon::Table.new(1, 1, default: 1)

  def initialize_events
    super

    on :unit_direction_change do
      if @unit.traits.key?('mapping')
        @mapping_render.mapping = @unit.traits['mapping'].mappings[@unit.direction]
      else
        @mapping_render.mapping = @@default_mapping
      end
    end
  end

  def refresh_unit
    @name_text.string = ''
    @unit_render.visual_info = nil
    @mapping_render.mapping = nil
    return unless @unit
    @unit_render.unit = @unit
    if tt = @unit.traits['tooltip']
      @name_text.string = tt['name'].to_s
    end

    @name_text.position.x = (@unit_background.w - @name_text.w) / 2
    @unit_render.position.x = (@unit_background.w - @unit_render.w) / 2
    @unit_render.position.y = (@unit_background.h - @unit_render.h) / 2
    @mapping_render.position.set(@unit_background.w, 0, 0)
  end

  def initialize_elements
    @unit_background = Moon::Spritesheet.new('resources/ui/gauge_512x512_transparent.png', 512, 512)
    @name_text = Moon::Label.new('', LunarMetal.cache.font('system', 16))
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
