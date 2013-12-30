# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_category do
	sequence(:name) {|n| "Category #{n}"}
end

  factory :product do
    sequence(:name) {|n| "Product #{n}"}
    description "Product is an etc..."
    :product_category
    wholesale_cost 100
    retail_price 150
  end

  factory :shopping_cart do
    #cart_token "MyString"
    :customer
  end
  
  factory :customer do
    factory :filled_in_customer do
      first_name "John"
      last_name "JacobsLadder"
      customer_token SecureRandom.uuid
    end
  end


  
end
