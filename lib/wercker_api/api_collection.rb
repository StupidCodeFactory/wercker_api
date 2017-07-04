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
      self.collection = collection.map { |item| item_klass.new(item) }
    end

    def each(&block)
      byebug
      collection.each(&block)
    end
    private

    def item_klass
      @klass ||= Kernel.const_get(self.class.name.sub(/Collection$/, ''))
    end
  end
end
