class Users::UsersController < ApplicationController
  before_filter :authenticate_access!, except: [:index, :update]
  before_filter :authenticate_user!, :only => [:update]
  before_filter :authenticate_admin!, :only => [:toggle_activation]
  skip_before_filter :verify_authenticity_token, only: [:toggle_activation]

  include InboxHelper

  def index
  end

  def profile
    @user = if current_admin.present?
      User.find_by_id(params[:user_id])
    else
      current_user
    end

    if @user.nil? || (current_admin.nil? && @user != current_user)
      flash[:alert] = 'Sorry, user not found!'
      redirect_to :back and return
    end

    @product = Product.first
    @pk_key = if Rails.env.production?
      ENV["PROD_PUBLISHABLE_KEY"]
    else
      ENV["TEST_PUBLISHABLE_KEY"]
    end
  end

  def update
    current_user.update(
    params.require(:user).permit(:first_name, :last_name, :time_zone))

    flash[:success] = "Successfully updated your profile!"
    redirect_to :back
  end

  def toggle_activation
    alert_text = ''
    begin
      ActiveRecord::Base.transaction do
        student = User.find(params[:user_id])
        if student.is_active?
          student.deactivate!
          alert_text = "deactivated"
        else
          student.activate!
          alert_text = "activated"
        end
      end
    rescue => e
      flash[:error] = "#{e.message}"
      redirect_to :back and return
    end

    flash[:success] = "Successfully #{alert_text} student!"
    redirect_to :back
  end

  def charge
    product = Product.find_by_code(params[:product_code])
    promo   = Promotion.find_by_id(params[:promo_id]) if params[:promo_id].present?

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
        Payment::PaymentProcessor.save_customer(user, params[:stripeToken])
      rescue Stripe::CardError => e
        err = e.json_body[:error][:message]
        msg = "Sorry, something went wrong while processing your payment, please try again."
        flash[:error] = err.present? ? "Sorry, #{err}, please try again." : msg

        redirect_to :back and return
      end
    end

    begin
      product.process_sale!(user: user, promotion: promo)
    rescue Payment::PaymentErrors => e
      flash[:error] = e.message
    rescue => e
      flash[:error] = "Sorry, something went wrong while processing your payment, please try again."
    end

    flash[:success] = "Thanks for your payment, you will be receiving a receipt shortly!"
    redirect_to :back
  end

end
