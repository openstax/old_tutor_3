class UsersController < ApplicationController

  layout "layouts/application_body_only"

  skip_before_filter :restrict_to_users_in_good_standing!

  def register
  end
end
