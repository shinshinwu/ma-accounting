class CreateEmailSettings < ActiveRecord::Migration
  def change
    create_table :email_settings do |t|
      t.string   :email, index: true, null: false
      t.boolean  :subscribed, index: true
      t.datetime :unsubscribed_at

      t.timestamps
    end
  end
end
