module Moon
  module DataModel
    class Metal
      def copy
        self.class.new.import(export)
      end
    end
  end
end
