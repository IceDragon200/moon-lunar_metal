module Moon
  class Table
    # @param [String] str
    # @param [Hash<String, Integer>] strmap
    # @return [self]
    def set_from_strmap(str, strmap)
      str.bytes.each_with_index { |c, i| set_by_index(i, strmap[c.chr]) }
      self
    end
  end
end
