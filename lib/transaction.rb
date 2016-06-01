class Transaction
    attr_reader :customer, :product, :id

    @@id = 0
    @@transactions = []
    @@refunds = []

    def initialize(customer, product, options = {})
        @customer = customer
        @product = product
        add_transaction
        if options[:refund] && refund_allowed? && !product.damaged
            puts "Refunding...!"
            increase_stock
        elsif options[:refund]
            puts "Not allowed refund"
        else
            reduce_stock
        end
    end

    def self.all
        @@transactions
    end

    def self.find(index)
        @@transactions[index - 1]
    end

    private

    def add_transaction
        @@id = @@id + 1
        @id = @@id
        @@transactions << self
    end

    #Checks customer is the same who purchases the item
    def refund_allowed?
        @@transactions.each do |purchase|
            if (purchase.customer == @customer) && (purchase.product == @product) && !refunded_item_before?
                return true
            else
                return false
            end
        end
        #Remove transation from list and into list of attempted refund
        @@refund << @@transactions.pop
        @@id = @id - 1
    end

    def refunded_item_before?
        @@refunds.each do |item| 
            if (item.customer == @customer) && (item.product == @product)
                return true
            else
                return false
            end
        end
        return false
    end

    def increase_stock
        @product.stock = @product.stock + 1
    end

    def reduce_stock
        @product.stock = @product.stock - 1
    end

end
