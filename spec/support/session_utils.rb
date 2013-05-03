# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

def session_sign_out
  if page.has_css? session_sign_out_selector
    elem = page.find session_sign_out_selector
    elem.click
  end
end

def session_sign_in
  user = user_create_confirmed
  session_sign_in_as(user)
end

def session_sign_in_as(user, args={})
  args = { email:     user.email,
           password:  session_default_user_password
         }.merge args

  visit new_user_session_path
  fill_in :user_email,    with: args[:email]
  fill_in :user_password, with: args[:password]
  click_on "sign-in"
end

def session_default_user_first_name
  "First"
end

def session_default_user_last_name
  "Last"
end

def session_default_user_password
  "password"
end

def session_default_user_email
  "user@example.com"
end

def session_sign_out_selector
  '[data-test-link-sign-out]'
end