class AddActiveToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :is_active, :boolean, null: false, default: true, after: :last_name
    add_index :users, :is_active
  end

  def self.down
    remove_column :users, :is_active
    remove_index :users, :is_active
  end
end
