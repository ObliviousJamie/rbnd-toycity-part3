class Transaction
    attr_reader :customer, :product, :id

    @@id = 0
    @@transactions = []

    def initialize(customer, product)
        @customer = customer
        @product = product
        add_transaction
        reduce_stock
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

    def reduce_stock
        @product.stock = @product.stock - 1
    end

end
