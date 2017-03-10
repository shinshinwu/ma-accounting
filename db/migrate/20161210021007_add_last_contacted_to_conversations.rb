class AddLastContactedToConversations < ActiveRecord::Migration
  def up
    add_column :conversations, :last_contacted_at, :datetime, null: false, after: :subject
    add_index :conversations, :last_contacted_at
  end

  def down
    remove_column :conversations, :last_contacted_at
    remove_index :conversations, :last_contacted_at
  end
end
