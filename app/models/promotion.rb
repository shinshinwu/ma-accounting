class Promotion < ActiveRecord::Base
  belongs_to :product, inverse_of: :promotions
  has_many :invoices, inverse_of: :promotion

  self.inheritance_column   = 'promotion_type'

  VALID_FREQUENCIES = ['fixed', 'daily', 'monthly']

  def currently_active?
    Date.current >= start_date && Date.current <= end_date
  end

  def valid_promotion?(p)
    product == p && currently_active?
  end

  def amount_discount(product)
    if valid_promotion?
    else
      0
    end
  end
end
