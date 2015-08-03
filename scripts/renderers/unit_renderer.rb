class UnitRenderer < Moon::RenderContainer
  attr_reader :visual_info
  attr_reader :visual_info_frames
  attr_reader :unit
  attr_accessor :frame_index
  attr_accessor :tilesize

  def initialize_elements
    super
    @frame_index = 0
    @anim_tick_max = 15 / 60.0
    @anim_tick = 0
    @anim_index = 0
    @tilesize = LunarMetal::System.tilesize
  end

  def refresh_visual_info
    @ss = nil
    @s = nil
    return unless @visual_info
    if ss_info = @visual_info.spritesheet
      @visual_info_frames = ss_info["frames"]

      filename = ss_info.filename

      if ss_info.cell_sizes?
        cw, ch = ss_info.cell_w, ss_info.cell_h
      elsif ss_info.table?
        t = LunarMetal.texture.tileset(filename)
        cw, ch = t.w / ss_info.cols, t.h / ss_info.rows
      else
        raise "ss_info was neither cellular nor tabular"
      end

      @ss = LunarMetal.cache.tileset(filename, cw, ch)
      self.w = @ss.w
      self.h = @ss.h
      @sox = @ss.w / 2
      @soy = @ss.h / 2
    elsif s_info = @visual_info.sprite
      @visual_info_frames = s_info["frames"]
      @s = Moon::Sprite.new(s_info.filename)
      self.w = @s.w
      self.h = @s.h
      @sox = @s.w / 2
      @soy = @s.h / 2
      @s.ox = @sox
      @s.oy = @soy
    end
  end

  def visual_info=(visual_info)
    @visual_info = visual_info
    refresh_visual_info
  end

  def unit=(unit)
    @unit = unit
    if @unit && (r = @unit.traits["render"])
      self.visual_info = LunarMetal.data.look(r.looks)
    else
      self.visual_info = nil
    end
  end

  def tick
    return unless @visual_info_frames
    return unless @unit
    @anim_index += 1
  end

  def update_frame(delta)
    frame = @visual_info_frames[@unit.frame_name]
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
    update_frame(delta)
    super
  end

  def render_elements(x, y, z, options={})
    if @unit
      if @ss
        @ss.render(x, y, z, @frame_index, options.merge(angle: @unit.angle, ox: @sox, oy: @soy))
      elsif @s
        @s.angle = @unit.angle
        @s.render(x, y, z)
      end
    end
    super
  end
end
