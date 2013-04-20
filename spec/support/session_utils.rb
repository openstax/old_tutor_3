def session_sign_out
  if page.has_css? session_sign_out_selector
    elem = page.find session_sign_out_selector
    elem.click
  end
end

def session_sign_in
  user = user_create
  session_sign_in_as(user)
end

def session_sign_in_as(user)
  visit new_user_session_path
  fill_in :user_email,    with: user.email
  fill_in :user_password, with: session_default_user_password
  click_on "sign-in"
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