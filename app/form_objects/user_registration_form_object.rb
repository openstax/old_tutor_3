class UserRegistrationFormObject

  extend  ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  def persisted?
    false
  end

  ATTRIBUTES = [ :first_name, :last_name, :email, :password, :password_confirmation ]
  attr_accessor *ATTRIBUTES

  validate do
    [user, user_account_info].each do |object|
      unless object.valid?
        object.errors.each do |key, value|
          errors[key] = value
        end
      end
    end
  end

  def initialize(attributes)
    ATTRIBUTES.each do |attribute|
      send("#{attribute}=", attributes[attribute])
    end
  end

  def save
    return false unless valid?
    return create_objects
  end

  def create_objects
    ActiveRecord::Base.transaction do
      user.save!
      user_account_info.save!
    end
  rescue
    false
  end

  def user
    @user ||= User.new email: email, password: password, password_confirmation: password_confirmation
  end

  def user_account_info
    @user_account_info ||= UserAccountInfo.new user: user, first_name: first_name, last_name: last_name
  end

  def method_missing(method_name, *args, &block)
    if user.respond_to? method_name
      user.send(method_name, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private=false)
    user.respond_to? method_name || super
  end

end
