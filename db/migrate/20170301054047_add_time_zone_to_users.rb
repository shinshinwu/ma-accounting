class AddTimeZoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string, null: false, default: 'Eastern Time (US & Canada)', after: :last_sign_in_ip
  end
end
