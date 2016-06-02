class Product
    attr_reader :title,:price, :department
    attr_accessor :stock,:damaged

    @@products = []

    def initialize(options={})
        @title = options[:title]
        @price = options[:price]
        @stock = options[:stock]
        @damaged = false
        @department = options[:department]
        add_to_products
    end

    #Returns an array of products
    def self.all
        @@products
    end

    #Returns all items that match a given title
    #Otherwise returns nil
    def self.find_by_title(name)
        @@products.each do |item|
            if name == item.title
                return item
            end
        end
        return nil
    end

    #Returns all items that match a given department
    #Otherwise returns nil
    def self.find_by_department(department)
        @@products.each do |item|
            if department == item.department
                return item
            end
        end
        return nil
    end

    #Makes item faulty
    def brake_item
        @damaged = true
    end

    def in_stock?
        @stock > 0
    end
    
    #Returns items that are in stock
    def self.in_stock
        @@products.find_all {|item| item.in_stock?}
    end

    private
    
    #Adds product to array or throws DuplicateProductError if there is
    #a product of the same name already
    def add_to_products
        @@products.each do |item|
            if self.title == item.title
                raise DuplicateProductError, "#{self.title} already exists."
            end
        end
        @@products << self
    end
end
