module States
  class Title < Base
    Command = Struct.new(:symbol, :string)

    def init
      super
      @controller = TitleController.new self

      cache = LunarMetal.cache
      pal = LunarMetal.data.palette
      @selected_color = pal['base0C']
      @unselected_color = pal['base07']
      @title_text = Moon::Label.new('Lunar Metal', cache.font('handel_gothic', 64), color: pal['base0D'])
      @commands = [
                    Command.new(:campaign, 'Campaign'),
                    Command.new(:skirmish, 'Skirmish'),
                    Command.new(:load_game, 'Load Game'),
                    Command.new(:options, 'Options'),
                    Command.new(:map, 'Map'),
                    Command.new(:unit_viewer, 'Unit Viewer'),
                    Command.new(:quit, 'Quit'),
                   ]
      @command_texts = @commands.map do |command|
        Moon::Label.new(command.string, cache.font('handel_gothic', 24))
      end
      h = 32 * @command_texts.size
      @command_texts.each_with_index do |text, i|
        text.position.set((screen.w - text.w) / 2,
                          (screen.h - h) / 2 + i * 32,
                          0)
      end
      @title_text.position.set(@command_texts[0].position)
      @title_text.position.x = (screen.w - @title_text.w) / 2
      @title_text.position.y -= @title_text.h + 32

      @i = 0
      @index = -1
      change_index 0
    end

    def change_index(index)
      time = 0.15
      if @index >= 0
        @command_texts[@index].transition :color, @unselected_color, time
      end
      @index = index
      if @index >= 0
        @command_texts[@index].transition :color, @selected_color, time
      end
    end

    def change_index_modulo(index)
      change_index(index.modulo(@commands.size))
    end

    def register_input
      super

      input.on :press do |e|
        case e.key
        when :up
          change_index_modulo(@index - 1)
        when :down
          change_index_modulo(@index + 1)
        when :enter
          case @commands[@index].symbol
          when :campaign
            @controller.campaign
          when :skirmish
            @controller.skirmish
          when :load_game
            @controller.load_game
          when :options
            @controller.options

          when :map
            @controller.map
          when :unit_viewer
            @controller.unit_viewer

          when :quit
            @controller.quit
          end
        end
      end
    end

    def update(delta)
      super
      @command_texts.each do |text|
        text.update delta
      end
    end

    def render
      super
      @title_text.render
      @command_texts.each(&:render)
    end
  end
end
