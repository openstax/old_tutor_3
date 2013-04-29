require 'spec_helper'

describe "registration page" do

  it "is loaded when visiting new_user_registration_path" do
    visit new_user_registration_path
    page_should_be_loaded 'new-user-registration'
  end

end

describe "user registration process" do

  context "successful registration and confirmation sequence" do

    it "sends the user an email with a valid confirmation link upon successful completion of form" do
      register_as email: 'user@example.com'

      page_should_be_loaded 'home'
      page_should_have_notice 'confirmation', 'user@example.com'

      email_deliveries.count.should eq 1

      email = email_body(email_deliveries.first)

      email_should_contain_confirmation_url(email)

      visit confirmation_path(email)

      page_should_be_loaded 'home'
      page_should_have_welcome_message
    end

  end

  def register_as(args)
    first_name    = args.fetch(:first_name,            session_default_user_first_name)
    last_name     = args.fetch(:last_name,             session_default_user_last_name)
    email         = args.fetch(:email)                 { raise ":email must be given" }
    password      = args.fetch(:password,              session_default_user_password)
    password_conf = args.fetch(:password_confirmation, password)
 
    visit_new_user_registration_page
    fill_in_first_name_with             first_name
    fill_in_last_name_with              last_name
    fill_in_email_with                  email
    fill_in_password_with               password
    fill_in_password_confirmation_with  password_conf
    click_submit
  end

  def visit_new_user_registration_page
    visit new_user_registration_path
  end

  def fill_in_first_name_with(name)
    fill_in :user_first_name, with: name
  end

  def fill_in_last_name_with(name)
    fill_in :user_last_name, with: name
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

  def email_should_contain_confirmation_url(email)
    email.should match confirmation_url_regex
  end

  def confirmation_path(email)
    email =~ confirmation_url_regex
    $1
  end

  def confirmation_url_regex
    %r{\"http:.+(/users/confirmation.*?)\"}  # do NOT include the http://hostname:port portion!
  end

end
