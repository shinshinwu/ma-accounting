class CreateQuizzAttempts < ActiveRecord::Migration
  def change
    create_table :quizz_attempts do |t|
      t.references :user, null: false
      t.references :quizz, null: false
      t.text       :correctly_answered, null: false
      t.boolean    :passed, null: false

      t.timestamps
    end

    add_index :quizz_attempts, [:quizz_id, :user_id]
  end
end
