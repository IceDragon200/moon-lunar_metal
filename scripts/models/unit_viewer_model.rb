class UnitViewerModel < StateModel
  field :unit,       type: Unit,     allow_nil: true, default: nil
  field :unit_node,  type: LinkNode, allow_nil: true, default: nil
end
