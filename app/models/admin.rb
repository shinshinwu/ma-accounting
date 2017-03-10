class Admin < ActiveRecord::Base
  include Conversable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  before_save   :prettify_name

  def self.send_broadcast(admin_id:, subject:, body:)
    admin = Admin.find_by_id(admin_id)
    if admin.present?
      students = User.active
      students.each do |student|
        convo = Conversation.create(
          sender:     admin,
          recipient:  student,
          subject:    subject
        )
        convo.messages.create!(
          sender:     admin,
          body:       body
        )
      end
    end
  end

  private

  def prettify_name
    self.first_name = first_name.split(' ').each(&:titleize).join(' ') if first_name
    self.last_name = last_name.split(' ').each(&:titleize).join(' ') if last_name
  end
end
