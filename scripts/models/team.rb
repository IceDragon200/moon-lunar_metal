class Team < Moon::DataModel::Base
  field :commander, type: Commander, default: ->(t,s){ t.model.new }
  field :faction,   type: Faction, allow_nil: true, default: nil
  field :metal,     type: Integer, default: 0
  field :energy,    type: Integer, default: 0
end
