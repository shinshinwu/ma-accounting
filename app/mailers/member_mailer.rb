class MemberMailer < ActionMailer::Base
  layout 'members/mailer'

  default :from => "Modern Assets <#{Settings.support_email}>"

  def initial_launch(member_id)
    @member = Member.find_by_id(member_id)

    if @member.present?
      subject = "The Best God Damn Accountant Marketing Course is here!"
      mail(from: "Marlon from Modern Assets <#{Settings.support_email}>",to: @member.email, subject: subject)
    end
  end
end
