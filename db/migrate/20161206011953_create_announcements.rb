class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.date       :start_date, null: false
      t.date       :end_date
      t.string     :title, null: false
      t.text       :description, null: false

      t.timestamps
    end
  end
end
