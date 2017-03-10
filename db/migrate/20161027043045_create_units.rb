class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string  :name, null: false
      t.integer :sort_order, null: false, unique: true
    end
  end
end
