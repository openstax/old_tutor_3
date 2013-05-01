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

  attr_accessible :first_name, :last_name

  VALID_EMAIL_REGEX = /\A[\w\.-]+@[\w-.]+\z/
  validates :email, presence: true,
                    length:   { minimum: 3, maximum: 320},
                    format:   { with: VALID_EMAIL_REGEX }

  VALID_NAME_REGEX = /\A[a-zA-Z]([-'a-zA-Z ]*[a-zA-Z])*?\z/
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :last_name,  presence: true, format: { with: VALID_NAME_REGEX }

  def first_name=(name)
    write_attribute :first_name, fixup_name(name)
  end

  def last_name=(name)
    write_attribute :last_name, fixup_name(name)
  end

private

  def fixup_name(name)
    name.split.join(" ") unless name.nil?
  end

end
