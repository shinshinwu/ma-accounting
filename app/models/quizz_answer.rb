class QuizzAnswer < ActiveRecord::Base
  belongs_to :question, class_name: "QuizzQuestion", foreign_key: :quizz_question_id, inverse_of: :answers

  scope :correct, -> (correct=true) { where(is_correct: correct) }

end
