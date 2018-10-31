class Atm

   attr_reader :balance

   def initialize(balance=0)
     @movements = []
     @balance = balance
   end

   def deposit (amount, date)

    return {
      status: :fail,
      error: :malformed_import
    } unless amount.is_a? Integer

     @movements << {
       type: :deposit,
       amount: amount,
       date: date
     }

     @balance = @balance + amount

    return_balance

   end

   def withdrawal(amount, date)

     return {
       status: :fail,
       error: :malformed_import
     } unless amount.is_a? Integer

     return {
       status: :fail,
       error: :insufficient_funds
     } if @balance < amount

     @movements << {
       type: :withdrawal,
       amount: amount,
       date: date
     }

     @balance = @balance - amount

     return_balance

   end

private

    def return_balance

      {
        status: :ok,
        balance: @balance
      }

    end
end
