require 'spec_helper'

describe ApplicationHelper do
	
	it "coverts cents to dollars" do
		to_dollars(78465).should eq("$784.65")
		to_dollars().should eq("$0.00")
		to_dollars(0).should eq("$0.00")
	end

	it "prints the role type" do
		get_role(true).should eq("Storekeeper")
		get_role(false).should eq("Customer")
	end
end