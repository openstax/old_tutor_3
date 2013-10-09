# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class ApplicationController < ActionController::Base
  protect_from_forgery

  include Lev::HandleWith

  before_filter :authenticate_user!
  before_filter :require_registration!
  before_filter :require_agreement_to_terms!

protected

  def require_registration!
    redirect_to users_registration_path if signed_in? && !current_user.is_registered?
  end

  def require_agreement_to_terms!
    return if !signed_in?

    true
    # look through which terms user has agreed to, if out of date, redirect to that page
    # (just go to the first one out of date, once agree, the next time in this method 
    # will get the next one)
    # do we need to track which agreements apply to which users?
    # should there be an gem that just has the model stuff?  (do we get that without mounting?)
  end

  def authenticate_admin!
    raise SecurityTransgression unless signed_in? && current_user.is_administrator?
  end
end
