module Moon
  class Vector3
    def sum
      x + y + z
    end

    def near?(other, threshold)
      diff = (self - other).abs
      (diff.x <= threshold.x && diff.y <= threshold.y && diff.z <= threshold.z)
    end

    def distance_from(target)
      (self - target).abs.sum
    end
  end
end
