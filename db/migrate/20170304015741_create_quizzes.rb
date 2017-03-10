class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.references :course_module, null: false, index: true
      t.string     :title, null: false
      t.integer    :passing_percentage, null: false, default: 90
    end

  end
end
