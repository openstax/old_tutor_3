# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
end
