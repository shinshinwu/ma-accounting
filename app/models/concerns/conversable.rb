module Conversable
  extend ActiveSupport::Concern

  included do
    has_many  :sent_conversations, as: :sender, class_name: "Conversation"
    has_many  :received_conversations, as: :recipient, class_name: "Conversation"
  end

  def name
    if first_name.present?
      "#{first_name.capitalize} #{last_name.capitalize}"
    else
      email
    end
  end

  def unread_conversations
    Conversation
      .engaged_by_member(self)
      .joins(:messages)
      .merge(Message.not_by_member(self).unread)
      .group('conversations.id')
      .order('last_contacted_at DESC')
  end

  def inbox_conversations
    # conversation is in a user's inbox if
    # 1) user is a recipient of the conversation
    # 2) user is the sender of the conversation and the conversation has messages other than send by the users
    convo_with_replies = sent_conversations
      .joins(:messages)
      .merge(Message.not_by_member(self).unread)

    Conversation
      .joins(:messages)
      .where
      .any_of(convo_with_replies, received_conversations)
      .order('last_contacted_at DESC')
  end

  def path_class
    self.class.to_s.underscore
  end
end
