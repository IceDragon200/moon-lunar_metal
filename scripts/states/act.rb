module States
  class Act < Base
    def init
      super
      @act_interpreter = ActIntepreter.new
    end

    def update(delta)
      super
    end

    def render
      super
    end
  end
end
