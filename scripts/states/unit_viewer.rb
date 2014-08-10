module States
  class UnitViewer < Base
    def init
      super
      @frames = [["sit", "up"], ["sit", "right"], ["sit", "down"], ["sit", "left"],
                 ["move", "up"], ["move", "right"], ["move", "down"], ["move", "left"],
                 ["dead", "up"], ["dead", "right"], ["dead", "down"], ["dead", "left"]
                 ].to_linked_list.loop!

      units = LunarMetal.data.entries(:unit).values
      units += LunarMetal.data.entries(:building).values
      units.map!(&:to_game_unit)
      @model = UnitViewerModel.new
      @model.unit_node = units.to_linked_list.loop!
      @view = UnitViewerView.new

      @input.on :press, :escape do
        State.pop
      end

      @input.on :press, :left do
        @model.unit_node = @model.unit_node.pred
        update_unit
      end

      @input.on :press, :right do
        @model.unit_node = @model.unit_node.succ
        update_unit
      end

      @scheduler.every "1s" do
        @frames = @frames.succ
        update_frame
      end
      update_unit
    end

    def update_frame
      frame, direction = @frames.value
      @model.unit.frame = frame
      @model.unit.direction = direction

      @view.trigger(:unit_direction_change)
    end

    def update_unit
      @model.unit = @model.unit_node.value

      @view.unit = @model.unit

      update_frame
    end

    def update(delta)
      super
      @view.update(delta)
    end

    def render
      super
      @view.render
    end
  end
end
