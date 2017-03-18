class CreateActivityTracker < ActiveRecord::Migration
  def change
    create_table :activity_trackers do |t|
      t.string :email, null: false, index: true
      t.string :key, index: true
      t.text   :parameters

      t.timestamps
    end
  end
end
