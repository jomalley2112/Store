require 'spec_helper'

feature 'visiting the root' do
	it "directs to the products listing page" do
		visit "/"
		page.should have_content("Products")
	end
end
