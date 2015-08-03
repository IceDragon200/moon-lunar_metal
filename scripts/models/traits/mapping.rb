class Trait::Mapping < Trait
  attr_writer :mappings
  field :directions, type: {String=>[String]}, default: nil

  def generate_mappings
    strmap = {
      's' => 1,
      'S' => 2,
      'w' => 3,
      'W' => 4,
      '.' => 200,
      ' ' => 0,
      'o' => 50,
    }

    directions.each_with_object({}) do |a, r|
      k, v = *a
      xsize = 0
      ysize = 0
      v.each do |row|
        xsize = row.size if xsize < row.size
      end
      ysize = v.size
      table = Moon::Table.new(xsize, ysize)
      table.set_from_strmap(v.join(''), strmap)
      r[k] = table
    end
  end

  def mappings
    @mappings ||= generate_mappings
  end
end
