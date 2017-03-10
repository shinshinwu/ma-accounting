class Quizz < ActiveRecord::Base
  belongs_to :course_module, inverse_of: :quizz
  has_many   :questions, class_name: "QuizzQuestion", inverse_of: :quizz, dependent: :destroy
  has_many   :attempts, class_name: "QuizzAttempt", inverse_of: :quizz, dependent: :destroy

  def have_passing_score?(num_correct_answers)
    num_correct_answers >= passing_score
  end

  # will return number of correct questions needed to pass
  def passing_score
    (passing_percentage * 0.01 * questions.size).round
  end

  def passed_by_user?(user)
    attempts.by_user(user).passed.exists?
  end

end
