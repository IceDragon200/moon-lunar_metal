module States
  class Splash < Base
    def init
      super
      @text = Moon::Text.new("Moon Engine", LunarMetal.cache.font("handel_gothic", 24))
      @moon_logo = Moon::Sprite.new("resources/splash/moon-logo.png")
      @moon_logo.ox = @moon_logo.width / 2
      @moon_logo.oy = @moon_logo.height / 2
      @opacity = 0.0
      @angle = -180.0

      add_transition @opacity, 1.0, 1.5, Moon::Easing::BackOut do |v|
        @opacity = v
      end

      add_transition @angle, 0.0, 1.5, Moon::Easing::BackOut do |v|
        @angle = v
      end

      @scheduler.in "500 3s" do
        add_transition @opacity, 0.0, 1.5, Moon::Easing::BackIn do |v|
          @opacity = v
        end
        add_transition @angle, 180.0, 1.5, Moon::Easing::BackIn do |v|
          @angle = v
        end
      end

      @scheduler.in "5s" do
        State.pop
      end

      @input.on :press, :enter do
        State.pop
      end

      @input.on :press, :f12 do
        State.change(States::Splash)
      end
    end

    def update(delta)
      super
    end

    def render
      super
      x = Moon::Screen.width / 2 - @moon_logo.width / 2
      y = Moon::Screen.height / 2 - @moon_logo.height / 2
      @moon_logo.opacity = @opacity
      @moon_logo.angle = @angle
      @moon_logo.render x, y, 0

      x = (Moon::Screen.width - @text.width) / 2
      y = (Moon::Screen.height - @text.height) / 2
      @text.render x, y, 0, opacity: @opacity, outline: 4
    end
  end
end
