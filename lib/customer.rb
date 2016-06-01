require_relative "transaction"
class Customer
    attr_reader :name

    @@customers = []

    def initialize(options = {})
        @name = options[:name]
        add_to_customers
    end

    def purchase(product)
        if product.in_stock? 
            Transaction.new(self,product)
        else
            raise OutOfStockError, "'#{product.title}' is out of stock."
        end
    end

    def return_item(product)
        Transaction.new(self,product,refund: product.title)
    end

    def brake_item(product)
        product.damaged = true
    end


    def self.all
        @@customers
    end

    def self.find_by_name(name)
        @@customers.each do |person|
            if name == person.name
                return person
            end
        end
        return nil
    end

    private

    def add_to_customers
        @@customers.each do |person|
            if self.name == person.name
                raise DuplicateProductError, "#{self.name} already exists."
            end
        end
        @@customers << self
    end
end
