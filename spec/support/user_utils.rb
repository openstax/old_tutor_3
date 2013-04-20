def user_create(args={})
  email = args[:email] || session_default_user_email

  user = User.create!(:email => email, :password => session_default_user_password, :password_confirmation => session_default_user_password)
  user.confirm!

  user
end
