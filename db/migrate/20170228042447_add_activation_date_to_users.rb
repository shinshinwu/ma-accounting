class AddActivationDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :deactivated_at, :datetime, null: true, after: :is_active
    add_column :users, :activated_at, :datetime, null: true, after: :is_active
  end
end
