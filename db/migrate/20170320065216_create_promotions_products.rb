class CreatePromotionsProducts < ActiveRecord::Migration
  def change
    create_table :products_promotions, id: false do |t|
      t.belongs_to :product, index: true
      t.belongs_to :promotion, index: true
    end
  end
end
