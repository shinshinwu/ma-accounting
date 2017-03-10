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

end
