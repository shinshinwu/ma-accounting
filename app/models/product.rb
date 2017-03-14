class Product < ActiveRecord::Base
  has_many :promotions, inverse_of: :product
  has_many :invoices, inverse_of: :product

  def process_sale!(user:, promotion:nil)
    if promotion.present?
      discount = promotion.discount_amount(self)
      total = (price - discount).to_f.round(2)

      generate_invoice!(user: user, amount: total, discount: discount, promotion: promotion)
    else
      # should probably raise error that can surface up
      generate_invoice!(user: user, amount: price)
    end

    # TODO: send receipt email to user
  end

  def promotional_price(promotion)
    discount = promotion.discount_amount(self)
    (price - discount).to_f.round(2)
  end

  def generate_invoice!(user:, amount:, discount: 0, promotion: nil)
    # prevent double charge
    return if invoices.by_user(user).paid.present?

    invoice = Invoice.new
    invoice.status = "pending"
    invoice.user = user
    invoice.product = self
    invoice.promotion = promotion
    invoice.billing_date = Date.current
    invoice.total_amount = amount
    invoice.discount_amount = discount

    begin
      if invoice.save
        return true
      elsif invoice.errors.present?
        AppLogger.error("Failed to generate invoice for product", "Failed to generate invoice for Product ##{self.id}: #{i.errors.full_messages}")
        return false
      end
    rescue Payment::PaymentErrors => e
      raise e #just bubble it up
    rescue => e
      AppLogger.error("Unexpected error while generating product invoice.",
            "Failed to generate invoice for Product ##{self.id} and user ##{user.id}: #{e.message}", e)
      return false
    end
  end

end
