module States
  class UnitViewer < Base
    def init
      super
      @frames = ["sit_up", "sit_right", "sit_down", "sit_left",
                 "move_up", "move_right", "move_down", "move_left",
                 "dead"].to_linked_list.loop!

      units = LunarMetal.data.entries(:unit).values
      units += LunarMetal.data.entries(:building).values
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
      @model.unit.frame = @frames.value
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
