class MappingCursorRenderer < Moon::RenderContainer
  attr_reader :mapping # Table

  def init_elements
    super
    @mapping = nil
    ts = LunarMetal::System.tilesize
    @sprite = Moon::Sprite.new("resources/ui/map_editor_cursor_#{ts.x.to_i}x#{ts.y.to_i}_ffffffff.png")
  end

  def refresh_mapping
    #
  end

  def mapping=(mapping)
    @mapping = mapping
    refresh_mapping
  end

  def render_elements(x, y, z, options={})
    if @mapping
      cw = @sprite.width
      ch = @sprite.height
      @mapping.ysize.times do |iy|
        dy = iy * ch
        @mapping.xsize.times do |ix|
          @sprite.render(x + ix * cw, y + dy, z) if @mapping[ix, iy] > 0
        end
      end
    end
    super
  end
end
