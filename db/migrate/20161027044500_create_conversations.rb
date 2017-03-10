class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string      :slug, null: false, limit: 35, index: true, unique: true
      t.integer     :sender_id,      null: false
      t.string      :sender_type,    null: false, limit: 10
      t.integer     :recipient_id,   null: false
      t.string      :recipient_type, null: false, limit: 10
      t.references  :course_module,  index: true
      t.string      :subject,        null: false, limit: 100

      t.timestamps
    end

    add_index :conversations, [:sender_id, :sender_type]
    add_index :conversations, [:recipient_id, :recipient_type]
  end
end
