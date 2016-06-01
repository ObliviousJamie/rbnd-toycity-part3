class Product
    attr_reader :title,:price
    attr_accessor :stock,:damaged

    @@products = []

    def initialize(options={})
        @title = options[:title]
        @price = options[:price]
        @stock = options[:stock]
        @damaged = false
        add_to_products
    end

    def self.all
        @@products
    end

    def self.find_by_title(name)
        @@products.each do |item|
            if name == item.title
                return item
            end
        end
        return nil
    end

    def in_stock?
        @stock > 0 ? true : false
    end
    
    def self.in_stock
        stocked = []
        @@products.each do |item|
            stocked << item if item.in_stock? 
        end
        stocked
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
