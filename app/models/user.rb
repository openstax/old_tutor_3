class User < ActiveRecord::Base
  ## NOTE: This class has been turned over to Devise.  Any additional
  ##       attributes should be placed elsewhere.

  # Include default devise modules. Others available are:
  # :token_authenticatable and :omniauthable
  devise  :database_authenticatable,  ## See DeviseCreateUsers migration
          :recoverable,               ## See DeviseCreateUsers migration
          :rememberable,              ## See DeviseCreateUsers migration
          :trackable,                 ## See DeviseCreateUsers migration
          :confirmable,               ## See DeviseCreateUsers migration
          :lockable,                  ## See DeviseCreateUsers migration
          :registerable,
          :timeoutable,
          :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, 
                  :password, :password_confirmation,
                  :remember_me
  # attr_accessible :title, :body
end
