class CursorRenderer < Moon::RenderContainer
  def init_elements
    super
    @sprite = Moon::Sprite.new("resources/ui/map_editor_cursor_32x32_ffffffff.png")
  end

  def render_elements(x, y, z, options={})
    @sprite.render(x, y, z)
    super
  end
end
