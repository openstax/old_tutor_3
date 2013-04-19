require 'spec_helper'

shared_examples_for "account bar: not logged in" do |visit_path|
  before :each do
    session_sign_out
  end

  it "contains a link to join" do
    visit visit_path
    page_should_have_link 'join'
  end

  it "contains a link to sign in" do
    visit visit_path
    page_should_have_link 'sign-in'
  end
end

shared_examples_for "account bar: logged in" do |visit_path|
  before :each do
    session_sign_in
  end

  it "contains a welcome message" do
    visit visit_path
    page_should_have_welcome_message
  end

  it "contains a link to sign out" do
    visit visit_path
    page_should_have_link 'sign-out'
  end

  def page_should_have_welcome_message
    page.should have_css '[data-test-user-welcome]'
  end
end
