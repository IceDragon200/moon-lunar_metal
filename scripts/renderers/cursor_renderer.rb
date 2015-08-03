class CursorRenderer < Moon::RenderContainer
  def initialize_elements
    super
    ts = LunarMetal::System.tilesize
    @sprite = Moon::Sprite.new(LunarMetal.texture.resource("resources/ui/map_editor_cursor_#{ts.x.to_i}x#{ts.y.to_i}_ffffffff.png"))

    self.w = @sprite.w
    self.h = @sprite.h
  end

  def render_elements(x, y, z, options)
    @sprite.render(x, y, z)
    super
  end
end
