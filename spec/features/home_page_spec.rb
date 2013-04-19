require 'spec_helper'

describe "home page" do

  it "is loaded when visiting root_path" do
    visit root_path
    home_page_should_be_loaded
  end

  context "user is not logged in" do
    before :each do
      sign_out
    end

    it "contains a link to join" do
      visit_home_page
      page_should_have_link_to_join
    end

    it "contains a link to sign in" do
      visit_home_page
      page_should_have_link_to_sign_in
    end
  end

  context "user is logged in" do

    before :each do
      sign_in
    end

    it "contains a welcome message" do
      visit_home_page
      page_should_have_welcome_message
    end

    it "contains a link to sign out" do
      visit_home_page
      page_should_have_link_to_sign_out
    end
  end

end

def visit_home_page
  visit root_path
end

def home_page_should_be_loaded
  page.should have_css('[data-test-page-home]')
end

def page_should_have_link_to_join
  page_should_have_data_test_link 'join'
end

def page_should_have_link_to_sign_in
  page_should_have_data_test_link 'sign-in'
end

def page_should_have_link_to_sign_out
  page_should_have_data_test_link 'sign-out'
end

def page_should_have_data_test_link(link_id)
  page.should have_css "a[data-test-link-#{link_id}]"
end

def page_should_have_welcome_message
  page.should have_css '[data-test-user-welcome]'
end
