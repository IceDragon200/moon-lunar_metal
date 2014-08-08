class Unit < Moon::DataModel::Metal
  attr_accessor :frame
  field :traits, type: Hash, default: proc{{}}

  def post_init
    super
    @frame = "sit_down"
  end
end
