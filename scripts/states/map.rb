module States
  class Map < Base
    def init
      super
      @game = Game.current = Game.new
      @game.set("mission" => false, "skirmish" => true)

      @map_view = MapView.new
      @ui_view = MapUiView.new

      @map_view_controller = MapViewController.new(@map_view)
      @map_view_controller.map = LunarMetal.data.map("testmap_1")

      @ui_view_controller = MapUiViewController.new(@ui_view)
      @ui_view_controller.update_metal(0)
      @ui_view_controller.update_energy(0)
    end

    def update(delta)
      super
      @map_view.update(delta)
      @ui_view.update(delta)
      @game.playtime += delta
    end

    def render
      @map_view.render
      @ui_view.render
      super
    end
  end
end
