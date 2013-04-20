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
      register_as email: "user@example.com", password: "password"

      page_should_be_loaded 'home'
      page_should_have_notice 'confirmation', 'user@example.com'

      email_deliveries.count.should eq 1

      email = email_body(email_deliveries.first)

      email.should match confirmation_url_regex

      email =~ confirmation_url_regex
      confirmation_path = $1

      visit confirmation_path

      page_should_be_loaded 'home'
      page_should_have_welcome_message
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

  def confirmation_url_regex
    %r{\"http:.+(/users/confirmation.*?)\"}  # do NOT include the http://hostname:port portion!
  end

  def register_as(args)
    email         = args.fetch(:email) { raise ":email must be given" }
    password      = args[:passowrd]              || session_default_user_password
    password_conf = args[:passowrd_confirmation] || password
 
    visit_new_user_registration_page
    fill_in_email_with                  email
    fill_in_password_with               password
    fill_in_password_confirmation_with  password_conf
    click_submit
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
