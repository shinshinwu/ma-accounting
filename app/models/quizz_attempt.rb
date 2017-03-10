class QuizzAttempt < ActiveRecord::Base
  belongs_to :user, inverse_of: :quizz_attempts
  belongs_to :quizz, inverse_of: :attempts

  scope :by_user, -> (user) { where(user_id: user) }
  scope :passed, -> (passed=true) { where(passed: passed) }

  serialize :correctly_answered # an array of correctly answered question ids

  after_create :mark_progress

  private

  def mark_progress
    if passed
      cc = user.course_completions.by_module(quizz.course_module).first
      cc.update_attribute(:completion_date, Date.current)
      user.course_progress.update_attribute(:current_module_id, quizz.course_module.next_module.id)
    end
  end
end
