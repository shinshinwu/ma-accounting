class AddTrackableToActivityTracker < ActiveRecord::Migration
  def change
    add_column :activity_trackers, :trackable_id, :integer, after: :key
    add_column :activity_trackers, :trackable_type, :string, after: :trackable_id
    add_index :activity_trackers, [:trackable_id, :trackable_type], name: "index_activity_on_trackable_id_and_type"

    add_column :activity_trackers, :recipient_id, :integer, after: :key
    add_column :activity_trackers, :recipient_type, :string, after: :recipient_id
    add_index :activity_trackers, [:recipient_id, :recipient_type], name: "index_activity_on_recipient_id_and_type"
  end
end
