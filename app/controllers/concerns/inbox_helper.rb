module InboxHelper
  extend ActiveSupport::Concern
  include ApplicationHelper

  def inbox
    # need to find a list of conversations that current user
    # 1) is a recipient of the convo
    # 2) is a sender of the convo but convo contains msg send by admin (not by current user).
    # 3) highlight a convo as unread if there is a message send by admin that is unread
    # 4) need to paginate
    convo = if params[:read] == "true"
      current_member.inbox_conversations.merge(Message.read)
    elsif params[:read] == "false"
      current_member.unread_conversations
    else
      current_member.inbox_conversations
    end

    @conversations = convo.group('conversations.id').order("last_contacted_at DESC").page params[:page]
  end

  def sentbox
    Conversation.joins(:messages).merge(Message.by_member(current_member)).group('conversations.id').order("last_contacted_at DESC").page params[:page]
  end

end
