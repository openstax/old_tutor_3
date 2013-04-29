class User < ActiveRecord::Base
  has_one   :user_account_info, inverse_of: :user, dependent: :destroy
  validates :user_account_info, presence: true

  accepts_nested_attributes_for :user_account_info
  attr_accessible :user_account_info_attributes

  after_initialize :add_user_account_info

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

private

  def add_user_account_info
    build_user_account_info if new_record? && user_account_info.nil?
  end

end
