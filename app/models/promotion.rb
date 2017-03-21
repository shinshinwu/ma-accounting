class Promotion < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_many :invoices, inverse_of: :promotion
  has_many :activity_trackers, as: :trackable

  self.inheritance_column   = 'promotion_type'

  VALID_FREQUENCIES = ['fixed', 'daily', 'monthly']

  validate :correctly_set_discount
  validates_presence_of :start_date, :end_date
  validate :correctly_set_dates
  validates :frequency, presence: true, inclusion: VALID_FREQUENCIES

  def currently_active?
    Date.current >= start_date && Date.current <= end_date
  end

  def valid_promotion?(p)
    products.include?(p) && currently_active?
  end

  def discount_amount(product)
    if valid_promotion?(product)
      process_discount(product)
    else
      0
    end
  end

  def process_discount
    # please see subclass
  end

  def duration
    days = (end_date - start_date).to_i
    if days > 3
      "#{days} days"
    else
      "#{days*24} hours"
    end
  end

  private

  def correctly_set_discount
    if amount_discount.present? && percentage_discount.present?
      errors[:base] << "You can only have 1 type of discount set at a time (amount or percentage)."
    end

    if amount_discount.nil? && ((percentage_discount >= 100) || (percentage_discount < 1))
      errors[:base] << "Percentage discount needs to be between 1 to 100."
    end

    max = products.maximum(:price) || Product.maximum(:price)
    if percentage_discount.nil? && ((amount_discount < 1) || (amount_discount >= max))
      errors[:base] << "Amount discount needs to be between $1 and $#{max}."
    end
  end

  def correctly_set_dates
    if start_date >= end_date
      errors[:base] << "Start date can not be later than end date."
    end
  end
end
