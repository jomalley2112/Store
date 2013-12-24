class AddCustomerTokenToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :customer_token, :string
  end
end
