class QuizzQuestion < ActiveRecord::Base
  belongs_to :quizz, inverse_of: :questions
  has_many :answers, class_name: "QuizzAnswer", inverse_of: :question, dependent: :destroy

  scope :sorted, -> { order(:sort_order) }

  def has_multiple_answers?
    answers.correct.size > 1
  end

  def has_one_answer?
    answers.correct.size == 1
  end

  def first_question?
    sort_order == 1
  end

  def last_question?
    quizz.questions.sorted.last == self
  end

  def > (other_question)
    sort_order > other_question.sort_order
  end

  def < (other_question)
    sort_order < other_question.sort_order
  end
end
