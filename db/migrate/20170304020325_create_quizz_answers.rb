class CreateQuizzAnswers < ActiveRecord::Migration
  def change
    create_table :quizz_answers do |t|
      t.references :quizz_question, null: false, index: true
      t.string     :description, null: false
      t.boolean    :is_correct, null: false

      t.timestamps
    end
  end
end
