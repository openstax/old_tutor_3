# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

def user_create_confirmed(args={})
  email = args[:email] || session_default_user_email

  user = User.new first_name:            session_default_user_first_name,
                  last_name:             session_default_user_last_name,
                  email:                 email, 
                  password:              session_default_user_password, 
                  password_confirmation: session_default_user_password
  user.skip_confirmation!
  user.save!
  user
end
