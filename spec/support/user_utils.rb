def create_user(args={})
  email = args[:email] || default_user_email

  user = User.create!(:email => email, :password => default_user_password, :password_confirmation => default_user_password)
  user.confirm!

  user
end
