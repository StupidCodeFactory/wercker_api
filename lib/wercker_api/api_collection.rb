module WerckerAPI
  module APICollection

    def self.included(klass)
      klass.class_eval do
        include Enumerable

        private
        attr_accessor :collection
      end
    end


    def initialize(collection = [])
      self.collection = collection
    end

    def each
      collection.each
    end
  end
end
