class Message < ActiveRecord::Base
  belongs_to :conversation, inverse_of: :messages
  belongs_to :sender, polymorphic: true

  validates_presence_of :body, :conversation_id, :sender_id

  scope :unread, -> { where(read: false) }
  scope :read, -> { where(read: true) }
  scope :by_member, -> (member) { where(sender_type: member.class.to_s, sender_id: member.id) }
  scope :not_by_member, -> (member) { where('((messages.sender_id != ? and messages.sender_type = ?) OR messages.sender_type != ?)', member.id, member.class.to_s, member.class.to_s) }

  def message_time
    if created_at.in_time_zone.to_date == Date.current
      created_at.in_time_zone.to_s(:hour_min)
    else
      created_at.in_time_zone.to_s(:month_day)
    end
  end

  def mark_read!
    self.update_attribute(:read, true)
  end
end
