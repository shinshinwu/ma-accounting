class Conversation < ActiveRecord::Base
  belongs_to :sender, polymorphic: true
  belongs_to :recipient, polymorphic: true
  belongs_to :course_module
  has_many :messages, dependent: :destroy, inverse_of: :conversation

  before_create :generate_slug

  scope :direct, -> { where('course_module_id is null') }
  scope :module_related, -> { where('course_module_id is not null') }
  scope :by_module, -> (course_module) { where(course_module_id: course_module) }
  scope :sent_by_member, -> (member) { where(sender: member) }
  scope :received_by_member, -> (member) { where(recipient: member) }
  scope :engaged_by_member, -> (member) { where.any_of(sent_by_member(member), received_by_member(member)) }

  # TODO: need to add a uniqueness validation for conversation per module

  # a viewer here can be an admin or an user
  def has_unread_msg?(member)
    if is_engaged_by?(member)
      messages.unread.not_by_member(member).exists?
    end
  end

  def is_engaged_by?(member)
    sender == member || recipient == member
  end

  def last_unread_msg_by(member)
    if is_engaged_by?(member)
      messages.unread.not_by_member(member).order('created_at DESC').first
    end
  end

  def last_message_time
    if last_contacted_at.in_time_zone.to_date == Date.current
      last_contacted_at.in_time_zone.to_s(:hour_min)
    else
      last_contacted_at.in_time_zone.to_s(:month_day)
    end
  end

  # given a person, who is the other person corresponding with
  def correspondent(member)
    sender == member ? recipient : sender
  end

  private

  def generate_slug
    self.slug = loop do
      hex = SecureRandom.hex(12)
      break hex unless self.class.exists?(slug: hex)
    end
  end
end
