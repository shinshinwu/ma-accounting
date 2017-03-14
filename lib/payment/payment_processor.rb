module Payment
  class PaymentErrors < StandardError
    def initialize(message="")
      super(message)
    end
  end

  class PaymentProcessor
    def self.sale!(amount:, user:, descriptor:'', metadata:{})
      # convert amount to cents as that's what stripe accepts
      amount = amount*100

      Stripe::Charge.create(
        amount:               amount,
        currency:             "usd",
        customer:             user.stripe_customer_id,
        statement_descriptor: descriptor,
        metadata:             metadata
      )
    end

    def self.save_customer!(user, stripe_token)
      customer = Stripe::Customer.create(
        email:  user.email,
        source: stripe_token
      )
      user.update_attribute(:stripe_customer_id, customer.id)
    end
  end
end
