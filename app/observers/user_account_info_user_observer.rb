class UserAccountInfoUserObserver < ActiveRecord::Observer
  observe User

  def after_destroy(user)
    debugger
    UserAccountInfo.where{user_id == user.id}.each{|uai| uai.destroy}
  rescue
  end
end