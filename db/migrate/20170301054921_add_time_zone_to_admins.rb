class AddTimeZoneToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :time_zone, :string, null: false, default: 'Eastern Time (US & Canada)', after: :remember_created_at
  end
end
