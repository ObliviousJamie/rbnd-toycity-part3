class Transaction
    attr_reader :customer, :product, :id

    @@id = 0
    @@transactions = []
    @@refunds = []

    def initialize(customer, product, options = {})
        @customer = customer
        @product = product
        add_transaction
        checks_refund(options)
    end

    #Returns all transations
    def self.all
        @@transactions
    end

    #Find and returns item at a given index
    def self.find(index)
        @@transactions.find{|id| id.id  == index}
    end

    private

    #Updates id of class variable and variable
    #Adds itself to array of transitons
    def add_transaction
        if @product.in_stock?
            @@id = @@id + 1
            @id = @@id
            @@transactions << self
        else
            raise OutOfStockError, "'#{product.title}' is out of stock."
        end
    end

    #Checks if this is a returned item
    def checks_refund(options ={})
        if options[:refund] && refund_allowed? && product.damaged
            puts "Refunding...!"
            increase_stock
        elsif options[:refund]
            puts "Not allowed refund"
        else
            reduce_stock
        end
    end

    #Checks customer is the same who purchases the item
    def refund_allowed?
        @@transactions.each do |purchase|
            if (purchase.customer == @customer) && (purchase.product == @product) && !refunded_item_before?
                attempted_refund
                return true
            else
                attempted_refund
                return false
            end
        end
    end

    def attempted_refund
        #Remove transation from list and into list of attempted refund
        @@refunds << @@transactions.pop
    end

    #Checks if someone has tried to return this item before
    def refunded_item_before?
        @@refunds.each do |item| 
            if (item.customer == @customer) && (item.product == @product)
                return true
            end
        end
        return false
    end

    def increase_stock
        @product.stock += 1
    end

    def reduce_stock
        @product.stock -= 1
    end

end
