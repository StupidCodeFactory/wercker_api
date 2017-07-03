module WerckerAPI
  class Application
    class BuildCollection
      include Enumerable
      def initialize(collection = [])
        self.collection = collection
      end

      def each
        collection.each
      end

      private
      attr_accessor :collection
    end
  end
end
