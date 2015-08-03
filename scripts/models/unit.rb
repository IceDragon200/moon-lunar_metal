class Unit < Moon::DataModel::Metal
  dict :traits,  key: String, value: Trait

  def to_game_unit
    GameUnit.new.tap { |m| m.update_fields(self) }
  end
end

class GameUnit < Unit
  class Health < Moon::DataModel::Metal
    field :value, type: Integer, default: 100
    field :max,   type: Integer, default: 100

    def rate
      value.to_f / max.to_f
    end
  end

  @@unit_id = 0

  field :health,    type: Health,        default: proc{ |t| t.model.new }
  field :angle,     type: Float,         default: 0.0
  field :frame,     type: String,        default: 'sit'
  field :direction, type: String,        default: 'down'
  field :unit_id,   type: Integer,       allow_nil: true, default: proc{ @@unit_id += 1 }
  field :cpos,      type: Moon::Vector2, allow_nil: true, default: proc{ |t| t.model.new }
  #field :velocity,  type: Numeric,       allow_nil: true, default: 0.0
  field :velocity,  type: Moon::Vector2, allow_nil: true, default: proc{ |t| t.model.new }
  field :accel,     type: Numeric,       allow_nil: true, default: 0.1
  field :deccel,    type: Numeric,       allow_nil: true, default: 0.05
  array :orders,    type: Order

  def frame_name
    "#{@frame}_#{@direction}"
  end

  def display_name
    ((t = traits['tooltip']) && t['name']) || '<Unknown>'
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
        ta = dv.angle.to_degrees - 90
        turn_speed = delta * 4
        move_speed = delta * 8
        self.angle = angle.lerp(ta, turn_speed)
        if (angle - ta).abs < 1
          self.velocity = dv * move_speed
        end

        #dv = cpos.turn_towards(order.target)
        #turn_speed = delta * 4
        #move_speed = delta * 8

        #self.angle = angle.lerp(dv.rad.to_degrees - 90, turn_speed)
        #self.velocity = [self.velocity + accel * delta, move_speed].min
      end

      if order.achieved?(self)
        orders.delete(order)
      end
    end

    self.cpos += velocity
    #self.cpos += Moon::Vector2.polar(1, self.angle.to_rads) * velocity
    #if self.velocity > 0
    #  self.velocity -= deccel * delta
    #  self.velocity = 0 if velocity < 0
    #end
  end
end
