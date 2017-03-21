class HomeController < ApplicationController
  layout 'home'

  def index
    @products = Product.order(:price)
    promo = Promotion.find_by_id(cookies.encrypted[:promotion_id])
    @promotion = promo if promo.present? && promo.currently_active?

    if params[:tracking].present?
      tracking_info = JSON.parse(Base64.urlsafe_decode64(params[:tracking]))
      activity = ActivityTracker.find_or_initialize_by(email: tracking_info["email"], key: 'landingpage.visit')

      cookies[:email] = tracking_info["email"]

      promo = Promotion.find_by_id(tracking_info["promotion_id"])
      if promo.present?
        activity.trackable = promo
        activity.parameters = {discount: promo.label}
        cookies.encrypted[:promotion_id] = promo.id
        @promotion ||= promo if promo.currently_active?
      end

      activity.save
    end
  end

  def checkout
    # ============ Payment Related Stuff ==================
    unless params[:show_success].present?
      @product = Product.find_by_code(params[:code])

      if @product.nil?
        flash[:error] = "Please choose your package first"
        redirect_to root_path and return
      end

      # track the visits to payment page
      if cookies["email"].present?
        activity = ActivityTracker.find_or_initialize_by(email: cookies["email"], key: 'checkout.visit')
        activity.recipient = @product

        promo = Promotion.find_by_id(cookies.encrypted[:promotion_id])

        if promo.present?
          activity.trackable = promo
          activity.parameters = {discount: promo.label, sale_price: @product.promotional_price(promo)}
        end

        activity.save
      end

      @pk_key = if Rails.env.production?
        ENV["PROD_PUBLISHABLE_KEY"]
      else
        ENV["TEST_PUBLISHABLE_KEY"]
      end

      @promotion = promo if promo.present? && promo.valid_promotion?(@product)
    end
  end

  def charge
    product = Product.find_by_code(params[:product_code])
    promo   = Promotion.find_by_id(params[:promo_id])
    invoice = nil

    user = if User.find_by_email(params[:user][:email]).nil?
      temp_pw = Devise.friendly_token
      User.create!(
        email:                 params[:user][:email],
        password:              temp_pw,
        password_confirmation: temp_pw,
        temprorary_password:   true
      )
    else
      User.find_by_email(params[:user][:email])
    end

    user.first_name = params[:user][:first_name]
    user.last_name  = params[:user][:last_name]
    user.zipcode    = params[:user][:zip]
    user.save!

    # new user? add customer and then process sale
    if user.stripe_customer_id.nil?
      begin
        Payment::PaymentProcessor.save_customer!(user, params[:stripeToken])
      rescue Stripe::CardError => e
        err = e.json_body[:error][:message]
        msg = "Sorry, something went wrong while processing your payment, please try again."
        flash[:error] = err.present? ? "Sorry, #{err}, please try again." : msg

        redirect_to :back and return
      end
    end

    # make sure don't double charge
    if user.invoices.by_product(product).exists?
      flash[:error] = "You can already purchased this course. Thanks for your support!"
      redirect_to :back and return

    else
      # process sale
      begin
        invoice = product.process_sale!(user: user, promotion: promo)
        cookies.delete(:promotion_id) if cookies.encrypted[:promotion_id].present?
      rescue Payment::PaymentErrors => e
        flash[:error] = e.message
      rescue => e
        flash[:error] = "Sorry, something went wrong while processing your payment, please try again."
        redirect_to :back and return
      end
    end

    redirect_to checkout_path(show_success: true, invoice_code: invoice.try!(:code))
  end

  def unsubscribe
  end

  def process_unsubscribe
    if User.where(email: params[:email]).exists? || Member.where(email: params[:email]).exists?
      EmailSetting.create(email: params[:email], subscribed: false, unsubscribed_at: Time.current)
    end

    # if we have no data on them, just return success
    flash[:success] = "You have successfully unsubscribed!"
    redirect_to :back
  end
end
