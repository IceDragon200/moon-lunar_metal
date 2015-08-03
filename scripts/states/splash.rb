module States
  class Splash < Base
    def init
      super
      @text = Moon::Label.new('Moon Engine', LunarMetal.cache.font('handel_gothic', 24), outline: 4, align: :center, opacity: 0.0)
      @moon_logo = Moon::Sprite.new('resources/splash/moon-logo.png')
      @moon_logo.origin.x = @moon_logo.w / 2
      @moon_logo.origin.y = @moon_logo.h / 2
      @angle = -180.0

      add_transition @text.opacity, 1.0, 1.5, Moon::Easing::BackOut do |v|
        @text.opacity = v
      end

      add_transition @angle, 0.0, 1.5, Moon::Easing::BackOut do |v|
        @angle = v
      end

      scheduler.in '500 3s' do
        add_transition @text.opacity, 0.0, 1.5, Moon::Easing::BackIn do |v|
          @text.opacity = v
        end
        add_transition @angle, 180.0, 1.5, Moon::Easing::BackIn do |v|
          @angle = v
        end
      end

      scheduler.in '5s' do
        state_manager.pop
      end

      input.on :press do |e|
        case e.key
        when :enter
          state_manager.pop
        when :f12
          state_manager.change(States::Splash)
        end
      end
    end

    def update(delta)
      super
    end

    def render
      super
      x = screen.w / 2
      y = screen.h / 2
      @moon_logo.opacity = @text.opacity
      @moon_logo.angle = @angle
      @moon_logo.render x, y, 0

      x = screen.w / 2
      y = screen.h / 2
      @text.render x, y, 0
    end
  end
end
