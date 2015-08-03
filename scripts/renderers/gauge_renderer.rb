class GaugeRenderer < Moon::RenderContainer
  attr_reader :rate
  attr_reader :texture
  attr_reader :gauge_size

  def initialize_elements
    super
    @rate = 1.0
    filename = "resources/ui/gauge_128x16_hp.png"

    @gauge_size = Moon::Vector2.new(128, 16)
    @base = Moon::Sprite.new(filename)
    @bar = Moon::Sprite.new(filename)
    self.texture = Moon::Texture.new(filename)
    refresh_rate
  end

  def setup(texture, w, h)
    @gauge_size = Moon::Vector2.new(w, h)
    self.texture = texture
  end

  def texture=(texture)
    @texture = texture

    refresh_texture
  end

  def refresh_rate
    @bar.clip_rect = Moon::Rect.new(@bar.clip_rect.x, @bar.clip_rect.y, @bar.texture.width * @rate, @bar.clip_rect.height)
  end

  def refresh_texture
    @base.texture = @texture
    @bar.texture = @texture
    @base.clip_rect = Moon::Rect.new(0, 0, @gauge_size.x, @gauge_size.y)
    @bar.clip_rect = Moon::Rect.new(0, 5 * @gauge_size.y, @gauge_size.x, @gauge_size.y)

    self.width = @base.width
    self.height = @base.height
    refresh_rate
  end

  def rate=(rate)
    orate = @rate
    @rate = [[rate, 0.0].max, 1.0].min.to_f
    refresh_rate if @rate != orate
  end

  def render_elements(x, y, z, options)
    @base.render(x - @base.ox, y - @base.oy, z)
    @bar.render(x - @bar.ox, y - @bar.oy, z)
    super
  end
end
