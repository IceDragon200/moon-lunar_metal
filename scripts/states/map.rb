module States
  class Map < Base
    def init
      super
      @game = Game.current = Game.new
      @game.set("mission" => false, "skirmish" => true)
      @game.world = World.new
      @game.world.map = LunarMetal.data.map("testmap_1").copy
      @world = @game.world
      @world.make_unit_map
      @world.camera.tilesize = LunarMetal::System.tilesize

      @game_controller = GameController.new(@game.world)

      @map_view = MapView.new
      @ui_view = MapUiView.new

      @map_view_controller = MapViewController.new(@map_view)
      @map_view_controller.map = @game.world.map

      @ui_view_controller = MapUiViewController.new(@ui_view)
      @ui_view_controller.metal = 0
      @ui_view_controller.energy = 0

      @world.camera.follow(@world.cursor)

      @game_controller.on :unit_added do |e|
        @map_view_controller.add_unit(e.unit)
        @ui_view_controller.unit_count = @world.units.size
        #pp e.unit
      end

      @game_controller.on :unit_removed do |e|
        @map_view_controller.remove_unit(e.unit)
        @ui_view_controller.unit_count = @world.units.size
        #pp e.unit
      end

      @input.on :any do |e|
        @world.cursor.trigger(e)
      end

      @test_unit = LunarMetal.data.unit("vtank")

      @world.cursor.on :action do |_,s|
        if unit = @game_controller.select_unit_at_pos(s.position)
          @world.selected_unit = unit
        elsif unit = @world.selected_unit
          unit.add_order(Order::Move.new(target: s.position))
        else
          unit = @test_unit.to_game_unit # also a nice way to copy it :3
          unit.cpos = s.position.dup
          @game_controller.add_unit unit
        end
      end

      @world.cursor.on :cancel do |_,s|
        @world.selected_unit = nil
      end

      @world.cursor.on :moved do |_,s|
        @map_view_controller.cursor_position = s.position
        @ui_view_controller.cursor_position = s.position
      end

      @world.cursor.activate
    end

    def update(delta)
      super
      @game.update(delta)
      @map_view_controller.camera_view = @world.camera.view
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
