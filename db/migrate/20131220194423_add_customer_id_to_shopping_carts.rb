class AddCustomerIdToShoppingCarts < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :customer_id, :integer
  end
end
