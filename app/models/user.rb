# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class User < ActiveRecord::Base
  
  belongs_to :openstax_connect_user, 
             class_name: "OpenStax::Connect::User"

  delegate :username, :first_name, :last_name, :name, :casual_name,
           to: :openstax_connect_user

  scope :registered, where(is_registered: true)
  scope :unregistered, where{is_registered != true}

  def is_administrator?
    is_administrator == true
  end

  def is_registered?
    is_registered == true
  end

  def is_anonymous?
    is_anonymous == true
  end

  #
  # Anonymous User stuff
  #

  attr_accessor :is_anonymous

  def self.anonymous
    @@anonymous ||= AnonymousUser.new
  end

  class AnonymousUser < User
    before_save { false } 
    def initialize(attributes=nil)
      super
      self.is_anonymous          = true
      self.is_registered         = false
      self.openstax_connect_user = OpenStax::Connect::User.anonymous
    end
  end

  #
  # OpenStax Connect "user_provider" methods
  #

  def self.connect_user_to_app_user(connect_user)
    return anonymous if connect_user.is_anonymous?

    app_user = where(openstax_connect_user_id: connect_user.id).first ||
               create do |user|
                 user.openstax_connect_user_id = connect_user.id
                 user.is_registered = false
               end
  end

  def self.app_user_to_connect_user(app_user)
    app_user.is_anonymous? ? OpenStax::Connect::User.anonymous : app_user.openstax_connect_user
  end

end
