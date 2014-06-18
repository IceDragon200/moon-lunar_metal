module States
  class Splash < Base

    def init
      super
      @text = Moon::Text.new("Moon Engine", LunarMetal.cache.font("handel_gothic", 24))
      @moon_logo = Moon::Sprite.new("resources/splash/moon-logo.png")
      @moon_logo.ox = @moon_logo.width / 2
      @moon_logo.oy = @moon_logo.height / 2
      @opacity = 0.0
      @angle = -90.0
      add_transition @opacity, 1.0, 1.5 do |v|
        @opacity = v
      end
      add_transition @angle, 0.0, 1.5 do |v|
        @angle = v
      end
      add_task 3.5 do
        add_transition @opacity, 0.0, 1.5 do |v|
          @opacity = v
        end
        add_transition @angle, 180.0, 1.5 do |v|
          @angle = v
        end
      end

      add_task 5 do
        State.pop
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
