module States
  class PreLoad < Base
    def init
      super
      Moon::DataLoader.file('armors').each do |filename|
        LunarMetal.data.armor(filename)
      end

      Moon::DataLoader.file('buildings').each do |filename|
        LunarMetal.data.building(filename)
      end

      Moon::DataLoader.file('looks').each do |filename|
        LunarMetal.data.look(filename)
      end

      Moon::DataLoader.file('units').each do |filename|
        LunarMetal.data.unit(filename)
      end

      Moon::DataLoader.file('weapons').each do |filename|
        LunarMetal.data.weapon(filename)
      end

      state_manager.pop
    end
  end
end
