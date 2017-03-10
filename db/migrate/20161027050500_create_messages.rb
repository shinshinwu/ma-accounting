class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references  :conversation
      t.integer     :sender_id,    null: false
      t.string      :sender_type,  null: false, limit: 10
      t.text        :body,         null: false
      t.boolean     :read,         null: false, default: false, index: true

      t.timestamps
    end

    add_index :messages, [:conversation_id, :sender_id, :sender_type], name: "index_messages_on_sender_id_and_type"
    add_index :messages, :created_at
  end
end
