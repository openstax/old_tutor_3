# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class UserAccountInfoUserObserver < ActiveRecord::Observer
  observe User

  def after_destroy(user)
    debugger
    UserAccountInfo.where{user_id == user.id}.each{|uai| uai.destroy}
  rescue
  end
end