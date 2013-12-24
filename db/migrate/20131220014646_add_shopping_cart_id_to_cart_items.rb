class AddShoppingCartIdToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :shopping_cart_id, :integer
  end
end
