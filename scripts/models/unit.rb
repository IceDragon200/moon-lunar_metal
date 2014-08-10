class Unit < Moon::DataModel::Metal
  field :traits,  type: {String=>Trait}, default: proc{{}}

  def to_game_unit
    GameUnit.new.tap { |m| m.set(self) }
  end
end

class GameUnit < Unit
  @@unit_id = 0

  field :angle,     type: Float,         default: 0.0
  field :frame,     type: String,        default: "sit"
  field :direction, type: String,        default: "down"
  field :unit_id,   type: Integer,       allow_nil: true, default: proc{@@unit_id+=1}
  field :cpos,      type: Moon::Vector2, allow_nil: true, default: proc{|t|t.new}
  field :velocity,  type: Moon::Vector2, allow_nil: true, default: proc{|t|t.new}
  array :orders,    type: Order

  def frame_name
    "#{@frame}_#{@direction}"
  end

  def add_order(order)
    orders.clear
    orders << order
  end

  def update(delta)
    order = orders.last

    self.velocity = Moon::Vector2.zero

    if order
      case order
      when Order::Move
        dv = cpos.turn_towards(order.target)
        ta = dv.rad.to_degrees - 90
        turn_speed = delta * 4
        move_speed = delta * 4
        self.angle = angle.lerp(ta, turn_speed)
        if (angle - ta).abs < 1
          self.velocity = dv * move_speed
        end
      end

      if order.achieved?(self)
        orders.delete(order)
      end
    end

    self.cpos += velocity
  end
end
