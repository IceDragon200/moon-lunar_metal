module Moon
  module Visibility
    attr_writer :visible

    def visible
      @visible = true if @visible.nil?
      @visible
    end

    def hide
      @visible = false
      self
    end

    def show
      @visible = true
      self
    end
  end
end

module Moon
  module Containable
    include Visibility
    include Eventable

    attr_accessor :parent

    def containerize
      container = RenderContainer.new
      container.add(self)
      container
    end

    def align!(*args)
      position.set(to_rect.align(*args).xyz)
    end
  end
end
