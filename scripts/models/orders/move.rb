class Order::Move < Order
  field :target, type: Moon::Vector2

  def post_initialize
    super
    @threshold = 0.4
  end

  def achieved?(unit)
    unit.cpos.near?(target, @threshold)
  end
end
