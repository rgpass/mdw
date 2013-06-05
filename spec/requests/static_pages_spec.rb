# This file runs a test-suite on the static pages
# This file was generated with the command:
# $ rails generate integration_test static_pages

require 'spec_helper'

describe "Static pages" do

	subject { page }

  shared_examples_for "All static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
  	before { visit root_path }
    let(:heading) { 'My Dysfunctional Workplace' }
    let(:page_title) { '' }
    
    it_should_behave_like "All static pages"
    it { should_not have_selector('title', text: '| Home') }
  end

  describe "FAQ page" do
  	before { visit faq_path }
    let(:heading) { 'Frequently Asked Questions' }
    let(:page_title) { 'FAQ' }

  	it_should_behave_like "All static pages"
  	it { should have_selector('title', text: '| FAQ') }
  end

  it "Should have the right links on the layout" do
    visit root_path
    click_link "Home"
    page.should have_selector 'title', text: full_title('')
    click_link "FAQ"
    page.should have_selector 'title', text: full_title('FAQ')
  end
end
