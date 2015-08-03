class UnitGaugeRenderer < GaugeRenderer
  def refresh_texture
    super
    @base.ox = @gauge_size.x / 2
    @base.oy = @gauge_size.y

    @bar.ox = @gauge_size.x / 2
    @bar.oy = @gauge_size.y
  end
end

class UnitNodeRenderer < Moon::RenderContainer
  attr_reader :unit
  attr_reader :tilesize

  def initialize_elements
    super
    @unit = nil
    @tilesize = LunarMetal::System.tilesize
    @unit_renderer = UnitRenderer.new

    @health_gauge = UnitGaugeRenderer.new
    @health_gauge.setup(LunarMetal.texture.ui("gauge_24x4_hp.png"), 24, 4)

    @health_gauge.position.y -= @health_gauge.height

    add(@unit_renderer)
    add(@health_gauge)
  end

  def refresh_unit
    @unit_renderer.unit = unit
  end

  def unit=(unit)
    @unit = unit
    refresh_unit
  end

  def tilesize=(tilesize)
    @tilesize = tilesize
    @unit_renderer.tilesize = tilesize
  end

  def update(delta)
    super
    if @unit
      px, py = *(@tilesize * @unit.cpos)
      position.set(px, py, 0)
      @health_gauge.position.x = @unit_renderer.width/2
      @health_gauge.rate = @unit.health.rate
    else
      @health_gauge.rate = 0.0
    end
  end
end
