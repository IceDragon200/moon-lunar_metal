class BuildControls
  include Moon::Eventable

end

class MouseMoveOnMapEvent < Moon::MouseMoveEvent
  attr_reader :original_event
  attr_reader :map_position

  def initialize(event, map_position)
    @original_event = event
    @map_position = map_position
    super @original_event.x, @original_event.y
    @type = :mousemove_on_map
  end
end

module States
  class Map < Base
    def init
      super
      @game = Game.current = Game.new
      @game.update_fields('mission' => false, 'skirmish' => true)
      @game.world = World.new camera: Camera2.new(view: screen.rect.translatef(-0.5, -0.5))
      @game.world.map = LunarMetal.data.map('testmap_02').copy
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

      @build_controls = BuildControls.new
      #@world.camera.follow(@world.cursor)

      @test_unit = LunarMetal.data.unit('vtank')
      @dir = ['down', 'right', 'up', 'left'].to_linked_list.loop!

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

      input.on :any do |e|
        @world.cursor.trigger(e)
        @ui_view.trigger(e)
      end

      input.on :mousemove do |e|
        map_position = (e.position + @world.camera.view).floor
        map_position /= @world.camera.tilesize
        input.trigger MouseMoveOnMapEvent.new(e, map_position.floor)
      end

      input.on :press, :space do |e|
        @dir = @dir.succ
        refresh_unit_mapping
      end

      @ui_view.building.build_queues.each do |q|
        q.on :build_order do |e|
          @test_unit = e.unit
          refresh_unit_mapping
        end
      end

      @world.cursor.on :select do |_, s|
        select_unit(@game_controller.select_unit_at_pos(s.position))
      end

      @world.cursor.on :action do |_, s|
        if unit = @world.selected_unit
          unit.add_order(Order::Move.new(target: s.position))
        else
          unit = @test_unit.to_game_unit # also a nice way to copy it :3
          unit.cpos = s.position.dup
          unit.direction = @dir.value
          @game_controller.add_unit unit
        end
      end

      @world.cursor.on :cancel do |_,s|
        select_unit nil
      end

      @world.cursor.on :moved do |_,s|
        @map_view_controller.cursor_position = s.position
        @ui_view_controller.cursor_position = s.position
      end

      @world.cursor.activate
    end

    def refresh_unit_mapping
      if @test_unit && @test_unit.traits['mapping']
        @map_view_controller.cursor_mapping = @test_unit.traits['mapping'].mappings[@dir.value]
      end
    end

    def select_unit(unit)
      @world.selected_unit = unit
      @ui_view_controller.unit = unit
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
