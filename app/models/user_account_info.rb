class UserAccountInfo < ActiveRecord::Base
  belongs_to :user, inverse_of: :user_account_info
  validates  :user, presence: true

  attr_accessible :user,
                  :first_name, :last_name

  validates :first_name, presence: true, format: { with: valid_name_regex }
  validates :last_name,  presence: true, format: { with: valid_name_regex }

  def first_name=(name)
    write_attribute :first_name, fixup_name(name)
  end

  def last_name=(name)
    write_attribute :last_name, fixup_name(name)
  end

  private

  def fixup_name(name)
    name.split.join(" ")
  end

  def valid_name_regex
    /\A[a-zA-Z]([-'a-zA-Z ]*[a-zA-Z])*?\z/
  end
end
