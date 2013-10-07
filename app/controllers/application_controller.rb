# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :restrict_to_users_in_good_standing!

protected

  def restrict_to_users_in_good_standing!
    redirect_to users_registration_path if signed_in? && !current_user.is_registered?
  end
end
