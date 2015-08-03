class SpritesheetInfo < Moon::DataModel::Metal
  field :filename,    type: String,  default: ""
  # spritesheets can either be loaded using their cell_*
  field :cell_w,      type: Integer, default: nil
  field :cell_h,      type: Integer, default: nil
  # or by using the provided cols and rows (which the cw, and ch are calculated from)
  field :cols,        type: Integer, default: nil
  field :rows,        type: Integer, default: nil

  # Was the size of a cell given?
  def cell_sizes?
    cell_w && cell_h
  end

  # Was the cols and rows given?
  def table?
    cols && rows
  end
end
