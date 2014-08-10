module Moon
  class Vector4
    def sum
      x + y + z + w
    end

    def near?(other, threshold)
      diff = (self - other).abs
      (diff.x <= threshold.x && diff.y <= threshold.y && diff.z <= threshold.z && diff.w <= threshold.w)
    end

    def distance_from(target)
      (self - target).abs.sum
    end
  end
end
