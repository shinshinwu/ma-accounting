class UserMailer < ActionMailer::Base
  layout 'members/mailer'

  include ActionView::Helpers::TextHelper

  default :from => "Modern Assets <#{Settings.support_email}>"

  def welcome_email(user_id)
    @user = User.find_by_id(user_id)
    subject = "Welcome to Modern Assets"
    if @user.present?
      mail(to: @user.email, subject: subject)
    end
  end

  def send_receipt(invoice_id)
    data = {transactional: true, track_clicks: false}

    @invoice = Invoice.find_by_id(invoice_id)
    @launch_date = Date.new(2017, 04, 25)
    if @invoice.present?
      @user    = @invoice.user
      @product = @invoice.product
      subject  = "Thank you for your recent purchase at Modern Assets"
      mail(to: @invoice.user.email, subject: subject, sparkpost_data: data)
    end
  end
end
