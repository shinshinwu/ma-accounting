class CreateCourseCompletions < ActiveRecord::Migration
  def change
    create_table :course_completions do |t|
      t.references :course_progress, null: false
      t.references :course_module, null: false
      t.date       :start_date
      t.date       :due_date
      t.date       :completion_date

      t.timestamps
    end

    add_index :course_completions, [:course_progress_id, :course_module_id], unique: true, name: "index_course_completions_on_progress_and_module"
  end
end
