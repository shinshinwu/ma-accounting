class CreateCourseModules < ActiveRecord::Migration
  def change
    create_table :course_modules do |t|
      t.references :unit,       null: false
      t.string     :name,       null: false
      t.integer    :sort_order, null: false

    end

    add_index :course_modules, [:unit_id, :sort_order], unique: true
    add_index :course_modules, :name
  end
end
