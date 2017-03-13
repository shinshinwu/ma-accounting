class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.references :product, index: true
      t.string     :promotion_type, null: false, index: true
      t.string     :frequency, null: false, index: true
      t.integer    :amount_discount, null: false
      t.integer    :percentage_discount
      t.date       :start_date
      t.date       :end_date

      t.timestamps
    end
  end
end
