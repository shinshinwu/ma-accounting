# a straightforward promotion model to allow a fixed dollar amount or percentage discount in a specific time range
class FixedPromotion < Promotion
  validate :correct_frequency

  def process_discount
    discount = if amount_discount.present?
      amount_discount
    else
      (product.price * percentage_discount * 0.01).to_f.round(2)
    end

    [discount, product.price].min
  end

  def label
    if amount_discount
      "$#{amount_discount} off"
    else
      "#{percentage_discount}% off"
    end
  end

  private

  def correct_frequency
    if frequency != 'fixed'
      errors[:base] << "You can only have fixed frequency for fixed promotion."
    end
  end
end
