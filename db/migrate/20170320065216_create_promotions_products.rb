class CreatePromotionsProducts < ActiveRecord::Migration
  def change
    create_table :products_promotions, id: false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :promotion, index: true
    end

    add_index :products_promotions, [:product_id, :promotion_id], unique: true
  end
end
