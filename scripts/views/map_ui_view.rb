class UnitStatusHud < Moon::RenderContainer
  attr_accessor :unit

  def initialize_elements
    super
    @unit = nil

    font = LunarMetal.cache.font('uni0553', 16)

    @name_text = Moon::Text.new('', font)
    @health_gauge = GaugeRenderer.new
    @health_gauge.position.y = 24

    add(@health_gauge)
    add(@name_text)
  end

  def update(delta)
    super
    if @unit
      @name_text.string = @unit.display_name
      @health_gauge.rate = @unit.health.rate
    else
      @health_gauge.rate = 0.0
    end
  end
end

class UnitActionHud < Moon::RenderContainer
  attr_accessor :unit

  def initialize_elements
    super
  end

  def update(delta)
    super
  end
end

class ResourcesHud < Moon::RenderContainer
  attr_reader :energy_text
  attr_reader :metal_text

  def initialize_elements
    super
    @background = Moon::SkinSlice3.new
    @background.windowskin = Moon::Spritesheet.new('resources/ui/hud_band_48x48_top.png', 48, 48)
    @background.width = @background.windowskin.cell_width * 2 * 3
    @background.height = @background.windowskin.cell_height

    font = LunarMetal.cache.font('uni0553', 24)
    @metal_text = Moon::Text.new('0', font)
    @energy_text = Moon::Text.new('0', font)

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

class BuildQueueHud < Moon::RenderContainer
  class BuildOrder < Moon::Event
    attr_reader :queue
    attr_reader :unit

    def initialize(queue, unit)
      @queue = queue
      @unit = unit
      super :build_order
    end
  end

  def initialize_elements
    super
    @font = LunarMetal.cache.font('system', 8)
    @ss = Moon::Spritesheet.new('resources/ui/gauge_64x64_transparent.png', 64, 64)
    @list = LunarMetal.data.entries(:building).values

    self.width = @ss.cell_width * 3
    self.height = ((@list.size/3)+[@list.size.modulo(3), 1].min) * @ss.cell_height
  end

  def initialize_events
    super
    on :press, :mouse_left do |e|
      click_pos = e.relative - position.xy
      if relative_contains_pos?(click_pos)
        x, y = *(click_pos / [@ss.cell_width, @ss.cell_height])
        index = x.to_i + y.to_i * 3
        if unit = @list[index]
          event = BuildOrder.new(nil, unit)
          trigger event
        end
      end
    end
    #on :press, :mouse_left do |e|
    #  puts e
    #end
  end

  def render_elements(x, y, z, options = {})
    @list.each_with_index do |u, i|
      xr, yr = x + (i % 3).to_i * @ss.cell_width, y + (i / 3).to_i * @ss.cell_height
      @ss.render(xr, yr, z, 5)
      if t = u.traits['tooltip']
        @font.render(xr, yr, 0, t['name'])
      end
    end
    super
  end
end

class BuildCommandHud < Moon::RenderContainer
  attr_reader :radar
  attr_reader :queue_index
  attr_reader :build_queues

  def initialize_elements
    super
    @radar = Moon::Spritesheet.new('resources/ui/gauge_192x192_transparent.png', 192, 192)

    @build_queues = Moon::SelectiveRenderArray.new
    @build_queues.add(BuildQueueHud.new)
    @build_queues.each do |q|
      q.position.y = @radar.cell_height
    end

    self.width = @radar.cell_width

    @build_queues.each { |e| add e }

    self.queue_index = 0
  end

  def queue_index=(index)
    @queue_index = index
    @build_queues.index = @queue_index
  end

  def render_elements(x, y, z, options={})
    @radar.render(x, y, z, 5)
    super
  end
end

class MapUiView < StateView
  attr_reader :unit_action
  attr_reader :unit_status
  attr_reader :cursor_text
  attr_reader :unit_count_text
  attr_reader :resources
  attr_reader :building

  def initialize_elements
    super
    font = LunarMetal.cache.font('uni0553', 16)
    @unit_action = UnitActionHud.new
    @unit_status = UnitStatusHud.new
    @resources = ResourcesHud.new
    @building = BuildCommandHud.new
    @cursor_text = Moon::Text.new('', font)
    @unit_count_text = Moon::Text.new('', font)

    @building.position.x = Moon::Screen.width - @building.width

    @cursor_text.position.y += 48
    @unit_count_text.position.y = @cursor_text.position.y + 24

    @unit_status.position.y = Moon::Screen.height - @unit_status.height

    add(@unit_action)
    add(@unit_status)
    add(@resources)
    add(@building)
    add(@cursor_text)
    add(@unit_count_text)
  end

  def initialize_events
    super
    #on :any do |e|
    #  #STDERR.puts [e].inspect
    #end
  end
end

class MapUiViewController
  def initialize(view)
    @view = view
  end

  def metal=(metal)
    @view.resources.metal_text.string = metal.to_s
  end

  def energy=(energy)
    @view.resources.energy_text.string = energy.to_s
  end

  def cursor_position=(v2)
    @view.cursor_text.string = v2.to_a.join(', ')
  end

  def unit_count=(i)
    @view.unit_count_text.string = i.to_s
  end

  def unit=(unit)
    @view.unit_status.unit = unit
  end
end
