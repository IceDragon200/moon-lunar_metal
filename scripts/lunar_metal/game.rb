module LunarMetal
  class Game < Moon::BaseModel

    class << self
      attr_accessor :current
    end
    field :commander, type: Commander, default: ->(t,s){ t.new }

  end
end
