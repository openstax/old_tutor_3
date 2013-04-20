# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class HomePageController < ApplicationController
  skip_before_filter :authenticate_user!

  layout "layouts/application_home_page"

  def index
  end

end