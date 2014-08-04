class UnitActionHud < Moon::RenderContainer
  def init_elements
    super
  end

  def update(delta)
    super
  end
end

class ResourcesHud < Moon::RenderContainer
  attr_reader :energy_text
  attr_reader :metal_text

  def init_elements
    super
    @background = Moon::SkinSlice3.new
    @background.windowskin = Moon::Spritesheet.new("resources/ui/hud_band_48x48_top.png", 48, 48)
    @background.width = @background.windowskin.cell_width * 2 * 3
    @background.height = @background.windowskin.cell_height

    font = LunarMetal.cache.font("uni0553", 24)
    @metal_text = Moon::Text.new("0", font)
    @energy_text = Moon::Text.new("0", font)

    @metal_text.position.set(@background.windowskin.cell_width*2,
                             (@background.windowskin.cell_height-@metal_text.font.size)/2,
                             0)
    @energy_text.position.set(@background.windowskin.cell_width*4,
                              (@background.windowskin.cell_height-@energy_text.font.size)/2,
                              0)

    add(@background)
    add(@metal_text)
    add(@energy_text)
  end

  def update(delta)
    super
  end
end

class MapUiView < StateView
  attr_reader :unit_action
  attr_reader :resources

  def init_elements
    super
    @unit_action = UnitActionHud.new
    @resources = ResourcesHud.new

    add(@unit_action)
    add(@resources)
  end
end

class MapUiViewController
  def initialize(view)
    @view = view
  end

  def update_metal(metal)
    @view.resources.metal_text.string = metal.to_s
  end

  def update_energy(energy)
    @view.resources.energy_text.string = energy.to_s
  end
end
