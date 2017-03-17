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

  def send_receipt(invoice_id)
    @invoice = Invoice.find_by_id(invoice_id)
    @launch_date = Date.new(2017, 04, 25)
    if @invoice.present?
      @user    = @invoice.user
      @product = @invoice.product
      subject  = "Thank you for your recent purchase at Modern Assets"
      mail(to: @invoice.user.email, subject: subject)
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
