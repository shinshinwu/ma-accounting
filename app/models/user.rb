class User < ActiveRecord::Base
  include Conversable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :course_cohort
  has_one   :course_progress, inverse_of: :user, dependent: :destroy
  has_many  :course_completions, through: :course_progress
  has_many  :quizz_attempts, inverse_of: :user, dependent: :destroy
  delegate  :current_module, to: :course_progress


  scope :active, -> { where(is_active: true) }

  before_save     :prettify_name
  before_create   :generate_access_token

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      if auth.info.first_name.present?
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
      elsif auth.info.name.present?
        names = auth.info.name.split(" ")
        user.first_name = names.first
        user.last_name = names[1..-1].join(" ")
      end
      user.password = Devise.friendly_token[0,20]
    end
  end

  def completed_modules
    CourseModule.joins(:unit)
      .where('units.sort_order <= ?', current_module.unit.sort_order)
      .where('course_modules.sort_order < ?', current_module.sort_order)
  end

  def activate!
    self.activated_at = Time.current
    self.is_active = true
    self.save!

    if self.course_progress.nil?
      progress = CourseProgress.create!(user: self, current_module: Unit.sorted.first.course_modules.sorted.first, start_date: Date.current)

      CourseCompletion.create!(course_progress: progress, course_module: progress.current_module, start_date: Date.current)
    end
  end

  def deactivate!
    self.deactivated_at = Time.current
    self.is_active = false
    self.save!
  end

  def name
    "#{first_name} #{last_name}"
  end

  private

  def prettify_name
    self.first_name = first_name.split(' ').each(&:titleize).join(' ') if first_name
    self.last_name = last_name.split(' ').each(&:titleize).join(' ') if last_name
  end

  def generate_access_token
    self.access_token = loop do
      random_token = SecureRandom.hex(8).upcase
      break random_token unless User.where(access_token: random_token).exists?
    end
  end
end
