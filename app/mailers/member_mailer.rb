class MemberMailer < ActionMailer::Base
  layout 'members/mailer'

  default :from => "Team at Modern Assets <#{Settings.support_email}>"

  def initial_launch(member_id)
    @member = Member.find_by_id(member_id)

    if @member.present?
      subject = "The Best God Damn Accountant Marketing Course is here!"
      mail(:to => @member.email, :subject => subject)
    end
  end
end
