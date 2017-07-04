module WerckerAPI
  class Application
    class DeployCollection

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
