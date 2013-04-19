require 'spec_helper'

describe "registration page" do

  it "is loaded when visiting new_user_registration_path" do
    visit new_user_registration_path
    page_should_be_loaded 'new-user-registration'
  end

end

describe "user registration" do

  context "successful registration" do

    it "sends user confirmation email upon successful completion of form" do
      ActionMailer::Base.deliveries = []

      visit_new_user_registration_page
      fill_in_email_with                  "user@example.com"
      fill_in_password_with               "password"
      fill_in_password_confirmation_with  "password"
      click_submit

      page_should_be_loaded 'home'
      page_should_have_notice 'confirmation link', 'sent', 'email'

      ActionMailer::Base.deliveries.count.should eq 1

      email = ActionMailer::Base.deliveries.first
      email.body.should match %r{"(http:.+/users/confirmation.*?)"}
      confirmation_path = $1
      visit confirmation_path

      page_should_be_loaded 'home'
      
    end

  end

  context "unsuccessful registrations" do
    it "does not allow two users to have the same email address" do

    end

    it "does not allow passwords of less than 8 characters" do

    end

    it "confirms that the user typed his password correctly" do

    end
  end

  def visit_new_user_registration_page
    visit new_user_registration_path
  end

  def fill_in_email_with(email_addr)
    fill_in :user_email, with: email_addr
  end

  def fill_in_password_with(password)
    fill_in :user_password, with: password
  end

  def fill_in_password_confirmation_with(password)
    fill_in :user_password_confirmation, with: password
  end

  def click_submit
    elem = page.find '[data-test-button-submit]'
    elem.click
  end
end
