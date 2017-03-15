class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  before_filter :set_time_zone
  before_action :set_raven_context

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

  # for error logging to send to sentry all available params to help debug
  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

end
