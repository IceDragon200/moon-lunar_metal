class Cursor < Moon::DataModel::Metal
  field :position, type: Moon::Vector2, default: proc{ |t| t.model.new }
end
