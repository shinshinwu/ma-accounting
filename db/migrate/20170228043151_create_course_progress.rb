class CreateCourseProgress < ActiveRecord::Migration
  def change
    create_table :course_progresses do |t|
      t.references :user, index: true, null: false
      t.integer    :current_module_id
      t.date       :start_date
      t.date       :end_date

      t.timestamps
    end
  end
end
