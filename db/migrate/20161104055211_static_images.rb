class StaticImages < ActiveRecord::Migration
  def change
    create_table :static_images do |t|
      t.string   :imageable_type, null: false
      t.integer  :imageable_id, null: false

      t.timestamps
    end

    add_index "static_images", ["imageable_type", "imageable_id"], :name => "index_static_images_on_imageable_type_and_imageable_id"
  end
end
