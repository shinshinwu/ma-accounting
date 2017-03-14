class Invoice < ActiveRecord::Base
  belongs_to :user, inverse_of: :invoices
  belongs_to :product, inverse_of: :invoices
  belongs_to :promotion, inverse_of: :invoices

  before_validation :generate_code, :on => :create
  before_create :charge!

  scope :by_product, -> (product) {where(product_id: product)}
  scope :by_user, -> (user) {where(user_id: user)}
  scope :paid, -> {where(status: 'paid')}

  def charged?
    transaction_id.present? || status == 'paid'
  end

  def charge!
    return false if charged?
    return false if user.nil? || product.nil? || total_amount.nil?
    # a user should only purchase a specific product once, this could change later
    return false if Invoice.by_product(product).by_user(user).exists?

    begin
      result = Payment::PaymentProcessor.sale!(
        amount:     total_amount,
        user:       user,
        descriptor: "MODERNASSETS*MKT",
        metadata: {
          user_id:      user.id,
          product_id:   product.id,
          promotion_id: promotion.try!(:id),
        }
      )

      if result.id
        self.status = 'paid'
        self.transaction_id = result.id
      end
    rescue Stripe::CardError => e
      body = e.json_body
      err  = body[:error]
      puts "Type is: #{err[:type]}"
      puts "Message is: #{err[:message]}" if err[:message]

      raise Payment::PaymentErrors.new(err[:message])
    end
  end


  private

  def generate_code
    chars = "234679ABCDEFGHJKTXYZ"
    begin
      self.code = ""
      8.times { |i| self.code << chars[rand(chars.length)] }
    end while Invoice.where(code: self.code).exists?
    return true
  end
end
