class CreateQuizzQuestions < ActiveRecord::Migration
  def change
    create_table :quizz_questions do |t|
      t.references :quizz, null: false
      t.integer    :sort_order, null: false
      t.string     :description, null: false

      t.timestamps
    end

    add_index :quizz_questions, [:quizz_id, :sort_order], unique: true
  end
end
