class AddTestingGroupToUsers < ActiveRecord::Migration
  def change
    add_column :users, :testing_group, :integer, after: :access_token
    add_index :users, :testing_group
    add_column :members, :testing_group, :integer, after: :id
    add_index :members, :testing_group
  end
end
