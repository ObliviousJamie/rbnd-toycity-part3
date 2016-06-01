require_relative "transaction"
class Customer
    attr_reader :name

    @@customers = []

    def initialize(options = {})
        @name = options[:name]
        add_to_customers
    end
    
    #Makes a new transation if a given item is in stock
    #Otherwise it will throw an OutOfStockError
    def purchase(product)
        if product.in_stock? 
            Transaction.new(self,product)
        else
            raise OutOfStockError, "'#{product.title}' is out of stock."
        end
    end

    #Makes a new transation, this time with a refund argument
    def return_item(product)
        Transaction.new(self,product,refund: product.title)
    end

    #Returns all customers
    def self.all
        @@customers
    end

    #Returns either name of person found or nothing
    def self.find_by_name(name)
        @@customers.each do |person|
            if name == person.name
                return person
            end
        end
        return nil
    end

    private

    #Adds a customer to the customer array unless they exist already
    #which throws a DuplicateProductError
    def add_to_customers
        @@customers.each do |person|
            if self.name == person.name
                raise DuplicateProductError, "#{self.name} already exists."
            end
        end
        @@customers << self
    end
end
