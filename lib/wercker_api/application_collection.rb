module WerckerAPI
  class ApplicationCollection
    include Enumerable

    def initialize(collection = [])
      self.collection = collection.map { |item| WerckerAPI::Application.new(item) }
    end

    def each
      collection.each
    end

    private

    attr_accessor :collection
  end
end
