class Product
    attr_reader :title

    @@products = []

    def initialize(options={})
        @title = options[:title]
        add_to_products
    end

    def self.all
        @@products
    end

    private

    def add_to_products
        @@products.each do |item|
            if self.title == item.title
                raise DuplicateProductError, "#{self.title} already exists."
            end
        end
        @@products << self
    end
end
