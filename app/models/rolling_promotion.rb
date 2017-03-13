# a special promotion model that in given time range and frequency, each new day/month we decrease the discount by a fixed dollar amount or percentage
# this way to create urgency for buyers to sign up as soon as possible
class RollingPromotion < Promotion
  validate :correct_frequency

  def process_discount
    multiplier = if frequency == 'daily'
      end_date - Date.current
    elsif frequency == 'monthly'
      if end_date.month == Date.current.month
        1
      else
        end_date.month - Date.current.month
      end
    end

    multiplier_amount = amount_discount || (product.price * percentage_discount * 0.01).to_i

    [multiplier_amount*multiplier, product.price].min
  end

  def label
    discount = if amount_discount
      "$ #{amount_discount} off"
    else
      "#{percentage_discount}% off"
    end

    occurence = frequency == 'daily' ? "every day" : "every month"

    "#{discount} #{occurence}"
  end

  private

  def correct_frequency
    if ['daily', 'monthly'].exclude?(frequency)
      errors[:base] << "Frequency needs to be daily or monthly for rolling promotion."
    end
  end
end
