class CreateSupportingMaterials < ActiveRecord::Migration
  def change
    create_table :supporting_materials do |t|
      t.references :course_module, null: false, index: true
      t.string     :title, null: false
      t.text       :description

      t.timestamps
    end
  end
end
