class UnitRenderer < Moon::RenderContainer
  attr_reader :visual_info
  attr_reader :visual_info_frames
  attr_reader :unit
  attr_accessor :frame_index

  def init_elements
    super
    @frame_index = 0
    @anim_tick_max = 15 / 60.0
    @anim_tick = 0
    @anim_index = 0
  end

  def refresh_visual_info
    @ss = nil
    @s = nil
    return unless @visual_info
    if ss_info = @visual_info.spritesheet
      @visual_info_frames = ss_info["frames"]
      @ss = LunarMetal.cache.tileset(ss_info.filename, ss_info.cell_width, ss_info.cell_height)
      self.width = @ss.cell_width
      self.height = @ss.cell_height
    elsif s_info = @visual_info.sprite
      @visual_info_frames = s_info["frames"]
      @s = Moon::Sprite.new(s_info.filename)
      self.width = @s.width
      self.height = @s.height
    end
  end

  def visual_info=(visual_info)
    @visual_info = visual_info
    refresh_visual_info
  end

  def unit=(unit)
    @unit = unit
    if @unit && (r = @unit.traits["render"])
      self.visual_info = LunarMetal.data.look(r["looks"])
    else
      self.visual_info = nil
    end
  end

  def tick
    return unless @visual_info_frames
    return unless @unit
    @anim_index += 1
    frame = @visual_info_frames[@unit.frame]
    if frame
      @frame_index = frame[@anim_index % frame.size]
    else
      @frame_index = 0
    end
  end

  def update(delta)
    @anim_tick -= delta
    while @anim_tick < 0
      tick
      @anim_tick += @anim_tick_max
    end
    super
  end

  def render_elements(x, y, z, options={})
    if @ss
      @ss.render(x, y, z, @frame_index, options)
    elsif @s
      @s.render(x, y, z)
    end
    super
  end
end
