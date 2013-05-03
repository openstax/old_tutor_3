# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

require 'spec_helper'

describe "registration page" do

  it "is loaded when visiting new_user_registration_path" do
    visit new_user_registration_path
    page_should_be_loaded 'new-user-registration'
  end

end

describe "user registration and account management features" do

  context "successful registration and confirmation sequence" do

    it "sends the user an email with a valid confirmation link upon successful completion of form" do
      register_as email: 'user@example.com'

      page_should_be_loaded 'home'
      page_should_have_info_alert 'confirmation', 'user@example.com'

      email_deliveries.count.should eq 1
      email = email_deliveries.first

      email.to.should eq ['user@example.com']

      email.body.decoded.should match confirmation_url_regexp

      visit confirmation_path(email)

      page_should_be_loaded 'home'
      page_should_have_welcome_message
    end

  end

  context "user changes registered email address sequence" do

    it "sends the user an email with a valid confirmation link upon successful completion of form" do
      user = user_create_confirmed email: 'user@example.com'

      session_sign_in_as(user)
      visit_edit_user_registration_page(user)

      change_email_address_to 'newuser@example.com'

      page_should_be_loaded 'home'
      page_should_have_info_alert 'confirmation', 'newuser@example.com'

      email_deliveries.count.should eq 1
      email = email_deliveries.first

      email.to.should eq ['newuser@example.com']
      email.body.decoded.should match confirmation_url_regexp

      visit confirmation_path(email)

      page_should_be_loaded 'home'
      page_should_have_welcome_message
    end

  end

  context "user account locking" do

    it "locks user account after 9th failed login attempt and sends email with a valid unlock link" do
      user = user_create_confirmed email: 'user@example.com', password: 'password'
      user_id = user.id

      8.times do
        session_sign_in_as user, password: 'not-the-password'
        page_should_be_loaded 'new-user-session'
        page_should_have_error_alert 'invalid'
        User.find(user_id).access_locked?.should be_false
      end
      session_sign_in_as user, password: 'not-the-password'
      page_should_be_loaded 'new-user-session'

      User.find(user_id).access_locked?.should be_true
      page_should_have_error_alert 'locked'

      email_deliveries.count.should eq 1
      email = email_deliveries.first

      email.to.should eq ['user@example.com']
      email.body.decoded.should match unlock_url_regexp

      visit unlock_path(email)
      page_should_be_loaded 'new-user-session'
      page_should_have_info_alert 'unlocked'
    end

    it "automatically unlocks a locked user account after one hour" do
      user = user_create_confirmed email: 'user@example.com', password: 'password'

      lock_time = Time.now

      Timecop.freeze lock_time do
        user.locked_at = Time.now
        user.save!
      end

      Timecop.freeze(lock_time + 1.hour - 1.second) do
        user.access_locked?.should be_true
      end

      Timecop.freeze(lock_time + 1.hour + 1.second) do
        user.access_locked?.should be_false
      end
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

  def change_email_address_to(email)
    fill_in_email_with            email
    fill_in_current_password_with session_default_user_password
    click_update
  end

  def visit_new_user_registration_page
    visit new_user_registration_path
    page_should_be_loaded 'new-user-registration'
  end

  def visit_edit_user_registration_page(user)
    visit edit_user_registration_path(user)
    page_should_be_loaded 'edit-user-registration'
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

  def fill_in_current_password_with(password)
    fill_in :user_current_password, with: password
  end

  def click_submit
    elem = page.find '[data-test-button-submit]'
    elem.click
  end

  def click_update
    elem = page.find '[data-test-button-update]'
    elem.click
  end

  def confirmation_path(email)
    extract_path(email, confirmation_url_regexp)
  end

  def unlock_path(email)
    extract_path(email, unlock_url_regexp)
  end

  def extract_path(email, regexp)
    email.body.decoded =~ regexp
    $1
  end

  def confirmation_url_regexp
    %r{\"http:.+(/users/confirmation.*?)\"}  # do NOT include the http://hostname:port portion!
  end

  def unlock_url_regexp
    %r{\"http:.+(/users/unlock.*?)\"}  # do NOT include the http://hostname:port portion!
  end

end
