class MessagesController < ApplicationController
  before_filter :authenticate_access!

  def create
    if params[:recipient_id] == "all" && current_admin.present?
      process_broadcast
    else
      # if it's first message, we need to establish context
      convo = if params[:message][:conversation_id].present?
        Conversation.find(params[:message][:conversation_id])
      else
        create_convo_context
      end

      msg   = Message.new(
        conversation_id: convo.id,
        sender: current_member,
        body: params[:message][:body]
      )

      if msg.save
        convo.update_attribute(:last_contacted_at, Time.current)
        # if a message has been replied to and there are unread msg for some reason, mark them read
        convo.messages.not_by_member(current_member).unread.each(&:mark_read!)
        flash[:success] = "Your message have been send!"
      else
        flash[:alert]   = "Sorry, something went wrong while sending your message"
      end
    end

    redirect_to :back
  end

  def process_broadcast
    # TODO: add delay job to broadcast job
    Admin.send_broadcast(admin_id: current_admin.id, subject: params[:subject], body: params[:message][:body])
    flash[:success] = "Your broadcast message have been send!"
  end

  def create_convo_context
    if params[:message][:module_id].present?
      course_module = CourseModule.find(params[:message][:module_id])
      subject       = "Question for Module #{course_module.sort_order} #{course_module.name}"
      module_id     = course_module.id
    else
      # it's send directly from inbox
      subject   = params[:subject]
      module_id = nil
    end

    recipient = if params[:recipient_id].present?
      User.find_by_id(params[:recipient_id])
    else
      Admin.first
    end

    Conversation.create!(
      sender:            current_member,
      recipient:         recipient,
      course_module_id:  module_id,
      subject:           subject,
      last_contacted_at: Time.current
    )
  end

end
