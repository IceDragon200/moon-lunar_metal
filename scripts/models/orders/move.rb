class Order::Move < Order
  field :target, type: Moon::Vector2

  def post_init
    super
    @threshold = Moon::Vector2.new(0.4, 0.4)
  end

  def achieved?(unit)
    unit.cpos.near?(target, @threshold)
  end
end
