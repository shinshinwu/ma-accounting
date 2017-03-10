class AuthenticationMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def reset_password_instructions(record, token, opts={})

    if record.is_a?(Admin)
      opts.merge!({
        subject:       'Reset Your Password',
        template_name: 'activate_account_instructions'
      })
    end
    super
  end
end
