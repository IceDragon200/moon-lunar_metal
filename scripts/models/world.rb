class World < Moon::DataModel::Metal
  field :map,         type: Map,         default: nil
  array :teams,       type: Team
  field :player_team, type: String,      default: ''
  array :units,       type: GameUnit
  field :unit_map,    type: Moon::Table, default: nil
  field :cursor,      type: MapCursor,   default: proc { |t| t.model.new }
  field :camera,      type: Camera2,     default: nil

  field :selected_unit, type: GameUnit,  default: nil

  def make_unit_map
    self.unit_map = Moon::Table.new(map.width, map.height, default: -1)
  end

  def update(delta)
    camera.update(delta)
    units.each_with_object(delta, &:update)
  end
end
