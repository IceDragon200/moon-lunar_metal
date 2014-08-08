module States
  class PreLoad < Base
    def init
      super
      DataLoader.file("armors").each do |filename|
        LunarMetal.data.armor(filename)
      end

      DataLoader.file("buildings").each do |filename|
        LunarMetal.data.building(filename)
      end

      DataLoader.file("looks").each do |filename|
        LunarMetal.data.look(filename)
      end

      DataLoader.file("units").each do |filename|
        LunarMetal.data.unit(filename)
      end

      DataLoader.file("weapons").each do |filename|
        LunarMetal.data.weapon(filename)
      end

      State.pop
    end
  end
end
