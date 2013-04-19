require 'spec_helper'

describe "home page" do

  it "appears when visiting the root path" do
    visit root_path
    page.should have_css('[data-test-page-home]')
  end

  it "contains a link to join" do
    visit root_path
    page.has_link?('[data-test-link-join]')
  end

  it "contains a link to sign in" do
    visit root_path
    page.has_link?('[data-test-link-sign-in]')
  end

end
