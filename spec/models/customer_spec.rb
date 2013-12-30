require 'spec_helper'

describe Customer do
	it "says whether or not it's filled in with a name" do
		customer = FactoryGirl.create(:customer)
		customer.filled_in?.should eq(false)
		customer = FactoryGirl.create(:filled_in_customer)
		customer.filled_in?.should eq(true)
	end
end