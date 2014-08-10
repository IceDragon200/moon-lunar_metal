class Numeric
  def lerp(target, d)
    self + (target - self) * d
  end

  def to_degrees
    57.2957795 * self
  end

  def to_rads
    self / 57.2957795
  end
end
