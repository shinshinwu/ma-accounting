class CreateCourseVideos < ActiveRecord::Migration
  def change
    create_table :course_videos do |t|
      t.references :course_content, null: false
      t.string     :title, null: false, index: true
      t.string     :url, null: false, unique: true
      t.integer    :sort_order, null: false
      t.integer    :length_minutes, null: false
      t.integer    :length_seconds, null: false

      t.timestamps
    end

    add_index :course_videos, [:course_content_id, :sort_order], unique: true
  end
end
