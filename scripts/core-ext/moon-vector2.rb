module Moon
  class Vector2
    def sum
      x + y
    end

    def near?(other, threshold)
      diff = (self - other).abs
      (diff.x <= threshold.x && diff.y <= threshold.y)
    end

    # https://searchcode.com/codesearch/view/561923/
    # Vector2.MoveTowards
    def move_towards(target, distance)
      diff = self - target
      angle = Math.atan2(diff.y, diff.x)
      self - [Math.cos(angle) * distance, Math.sin(angle) * distance]
    end

    def turn_towards(target)
      diff = target - self
      angle = Math.atan2(diff.y, diff.x)
      Vector2.new(Math.cos(angle), Math.sin(angle))
    end

    def distance_from(target)
      (self - target).abs.sum
    end
  end
end
