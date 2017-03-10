class UserMailer < ActionMailer::Base

  add_template_helper(ApplicationHelper)
  include ActionView::Helpers::TextHelper

  default from: Settings.donotreply_email

  # enable BCC for production emails for loggin purpose
  default bcc: Settings.bcc_email if Rails.env.production?

  def welcome_email(user_id)
    @user = User.find_by_id(user_id)
    subject = "Welcome to Modern Assets"
    if @user.present?
      mail(to: @user.email, subject: subject)
    end
  end
end
