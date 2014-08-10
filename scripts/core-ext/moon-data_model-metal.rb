module Moon
  module DataModel
    class Metal
      def copy
        self.class.new.set(self.to_h)
      end
    end
  end
end
