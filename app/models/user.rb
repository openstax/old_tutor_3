class User < ActiveRecord::Base
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

  VALID_EMAIL_REGEX = /\A[\w\.-]+@[\w-.]+\z/
  validates :email, presence: true,
                    length:   { minimum: 3, maximum: 320},
                    format:   { with: VALID_EMAIL_REGEX }
end
