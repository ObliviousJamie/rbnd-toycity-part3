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
            Transaction.new(self,product)
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
        @@customers.find{|person| person.name == name}
    end

    private

    #Adds a customer to the customer array unless they exist already
    #which throws a DuplicateCustomerError
    def add_to_customers
        @@customers.each do |person|
            if self.name == person.name
                raise DuplicateCustomerError, "#{self.name} already exists."
            end
        end
        @@customers << self
    end
end
