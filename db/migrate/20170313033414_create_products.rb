class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string  :code, null: false, index: true
      t.string  :description, null: false
      t.integer :amount, null: false

      t.timestamps
    end
  end
end
