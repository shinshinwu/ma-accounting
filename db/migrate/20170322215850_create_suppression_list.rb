class CreateSuppressionList < ActiveRecord::Migration
  def change
    create_table :suppression_lists do |t|
      t.string :email, null: false, index: true, unique: true
      t.string :source, null: false, index: true

      t.timestamps
    end
  end
end
