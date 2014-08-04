class InputProcessor
  def initialize(input)
    @input = input
    @click_table = {}
  end

  def on(feature, *args, &block)
    case feature
    when :click, :tap
      key, = *args
      @input.on :press, key do
        @click_table[key] = true
      end
      @input.on :release, key do |*a|
        if @click_table[key]
          block.call(*a)
          @click_table[key] = false
        end
      end
    else
      @input.on(:feature, *args, &block)
    end
  end
end
