module States
  class Title < Base
    Command = Struct.new(:symbol, :string)

    def init
      super
      @controller = TitleController.new

      cache = LunarMetal.cache
      pal = LunarMetal.data.palette
      @selected_color = pal["base0C"]
      @unselected_color = pal["base07"]
      @title_text = Moon::Text.new("Lunar Metal", cache.font("handel_gothic", 64))
      @title_text.color = pal["base0D"]
      @commands = [
                    Command.new(:campaign, "Campaign"),
                    Command.new(:skirmish, "Skirmish"),
                    Command.new(:load_game, "Load Game"),
                    Command.new(:options, "Options"),
                    Command.new(:map, "Map"),
                    Command.new(:unit_viewer, "Unit Viewer"),
                    Command.new(:quit, "Quit"),
                   ]
      @command_texts = @commands.map do |command|
        Moon::Text.new(command.string, cache.font("handel_gothic", 24))
      end
      h = 32 * @command_texts.size
      @command_texts.each_with_index do |text, i|
        text.position.set((Moon::Screen.width - text.width)/2,
                          (Moon::Screen.height - h) / 2 + i * 32,
                          0)
      end
      @title_text.position.set(@command_texts[0].position)
      @title_text.position.x = (Moon::Screen.width - @title_text.width) / 2
      @title_text.position.y -= @title_text.height + 32

      @index = -1
      change_index 0
      register_input
    end

    def change_index(index)
      @command_texts[@index].transition :color, @unselected_color if @index >= 0
      @index = index
      @command_texts[@index].transition :color, @selected_color if @index >= 0
    end

    def register_input
      @input.on :press, :up do
        change_index @index.pred.modulo(@commands.size)
      end

      @input.on :press, :down do
        change_index @index.succ.modulo(@commands.size)
      end

      @input.on :press, :enter do
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
