class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :user, index: true
      t.string     :code, null: false, index: true
      t.date       :billing_date, null: false
      t.decimal    :total_amount
      t.string     :transaction_id

      t.timestamps
    end
  end
end
