class AddStripeCustomerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_id, :string, after: :zipcode
  end
end
