class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :product_category_id
      t.integer :wholesale_cost
      t.integer :retail_price

      t.timestamps
    end
  end
end
