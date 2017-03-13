class AddProductToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :product_id, :integer, after: :user_id
    add_index :invoices, :product_id
    add_column :invoices, :promotion_id, :integer, after: :product_id
    add_index :invoices, :promotion_id
    add_column :invoices, :status, :string, after: :id, null: false
    add_index :invoices, :status
    add_column :invoices, :discount_amount, :decimal, after: :total_amount
  end
end
