class Pilot < Moon::DataModel::Base
  field :exp,   type: Integer, default: 0
  field :level, type: Integer, default: 1
  field :rank,  type: Integer, default: 0
end
