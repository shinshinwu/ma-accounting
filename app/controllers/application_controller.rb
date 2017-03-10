class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_filter :set_time_zone

  def set_time_zone
      Time.zone = current_member.time_zone if current_member
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      profile_user_path(resource_or_scope)
    elsif resource_or_scope.is_a?(Admin)
      profile_admin_path(resource_or_scope)
    else
      super
    end
  end

  def authenticate_access!
    if admin_signed_in?
      true
    else
      authenticate_user!
    end
  end

end
