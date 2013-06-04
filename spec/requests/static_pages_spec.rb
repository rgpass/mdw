# This file runs a test-suite on the static pages
# This file was generated with the command:
# $ rails generate integration_test static_pages

require 'spec_helper'

describe "Static pages" do

	subject { page }

  describe "Home page" do
  	before { visit '/static_pages/home' }
    
    it { should have_content('My Dysfunctional Workplace') }
    it { should have_selector('title', text: 'My Dysfunctional Workplace') }
  end

  describe "FAQ page" do
  	before { visit '/static_pages/faq' }

  	it { should have_content('Frequently Asked Questions') }
  	it { should have_selector('title', text: '| FAQ') }
  end
end
