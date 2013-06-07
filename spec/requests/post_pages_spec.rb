require 'spec_helper'

describe "PostPages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

  describe "Post creation" do
    before { visit new_post_path }

    describe "With invalid information" do

    	it "Should not create a post" do
    		expect { click_button "Post" }.not_to change(Post, :count)
    	end

    	describe "Error messages" do
    		before { click_button "Post" }
    		it { should have_content('error') }
    	end
    end

    describe "With valid information" do

    	before { fill_in 'post_content', with: "Lorem ipsum" }
    	it "Should create a post" do
    		expect { click_button "Post" }.to change(Post, :count).by(1)
    	end
    end
  end
end
