class UserAccountInfo < ActiveRecord::Base
  VALID_NAME_REGEX = /\A[a-zA-Z]([-'a-zA-Z ]*[a-zA-Z])*?\z/

  belongs_to :user

  attr_accessible :user,
                  :first_name, :last_name

  validates :user,       presence: true
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
