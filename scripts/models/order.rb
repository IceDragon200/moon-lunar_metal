class Order < Moon::DataModel::Metal
  def achieved?(unit)
    true
  end
end

require "scripts/models/orders/move"
