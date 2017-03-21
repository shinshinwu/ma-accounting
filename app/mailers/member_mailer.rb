class MemberMailer < ActionMailer::Base
  layout 'members/mailer'

  default :from => "Modern Assets <#{Settings.support_email}>"

  def plain_launch(member_id, promotion_id:, campaign_id: "acounting-inital-launch")
    data = {campaign_id: campaign_id}
    @member = Member.find_by_id(member_id)
    @launch_date = Date.new(2017, 04, 30)

    if @member.present?
      @promo = Promotion.find_by_id(promotion_id)
      @tracking_info = Base64.urlsafe_encode64({promotion_id: promotion_id, email: @member.email}.to_json)
      subject = "The Best Thing To Happen To Accountants In 2017 Thus Far"
      mail(from: "Marlon from Modern Assets <#{Settings.support_email}>",to: @member.email, subject: subject, sparkpost_data: data) do |format|
        format.html { render layout: false }
      end
    end
  end

  def initial_launch(member_id)
    data = {campaign_id: "acounting-inital-launch"}
    @member = Member.find_by_id(member_id)

    if @member.present?
      subject = "The Best God Damn Accountant Marketing Course is here!"
      mail(from: "Marlon from Modern Assets <#{Settings.support_email}>",to: @member.email, subject: subject, sparkpost_data: data)
    end
  end

  # this sends a template for section by section promo email template
  def section_promo(member_id)
    @member = Member.find_by_id(member_id)

    if @member.present?
      subject = "The Best God Damn Accountant Marketing Course is here!"
      mail(from: "Marlon from Modern Assets <#{Settings.support_email}>",to: @member.email, subject: subject)
    end
  end

  # this sends a template for typical faq email
  def frequent_faq(member_id)
    @member = Member.find_by_id(member_id)

    if @member.present?
      subject = "Welcom to Modern Assets! How can we help you better?"
      mail(from: "Marlon from Modern Assets <#{Settings.support_email}>",to: @member.email, subject: subject)
    end
  end

  # this sends a template for a checklist style email
  def checklist_promo(member_id)
    @member = Member.find_by_id(member_id)

    if @member.present?
      subject = "Ways Modern Assets Can Help Your Accounting Practice!"
      mail(from: "Marlon from Modern Assets <#{Settings.support_email}>",to: @member.email, subject: subject)
    end
  end
end
