class CreateCourseAssignments < ActiveRecord::Migration
  def change
    create_table :course_assignments do |t|
      t.references :course_module, null: false
      t.string     :title, null: false
      t.text       :instructions, null: false
      t.integer    :sort_order, null: false

      t.timestamps
    end
    add_index :course_assignments, [:course_module_id, :sort_order], unique: true
  end
end
