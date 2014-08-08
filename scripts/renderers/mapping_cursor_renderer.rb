class MappingCursorRenderer < Moon::RenderContainer
  attr_reader :mapping

  def init_elements
    super
    @mapping = nil
    @sprite = Moon::Sprite.new("resources/ui/map_editor_cursor_32x32_ffffffff.png")
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
      @mapping.each_with_index do |row, iy|
        dy = iy * ch
        row.each_with_index do |b, ix|
          @sprite.render(x + ix * cw, y + dy, z) if b
        end
      end
    end
    super
  end
end
