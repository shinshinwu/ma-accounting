class CreateCourseContents < ActiveRecord::Migration
  def change
    create_table :course_contents do |t|
      t.references :course_module, null: false, index: true
      t.text       :description
      t.integer    :sort_order, null: false

      t.timestamps
    end

    add_index :course_contents, [:course_module_id, :sort_order], unique: true
  end
end
