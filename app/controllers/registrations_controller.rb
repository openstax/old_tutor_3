# Copyright 2011-2013 Rice University. Licensed under the Affero General Public 
# License version 3 or later.  See the COPYRIGHT file for details.

class RegistrationsController < Devise::RegistrationsController
  layout "layouts/application_body_only"

  def set_flash_message(key, kind, options={})
    options.merge!  email:              resource.email,
                    unconfirmed_email:  resource.unconfirmed_email,
                    first_name:         resource.first_name,
                    last_name:          resource.last_name
    message = find_message(kind, options)
    flash[key] = message if message.present?
  end

  def find_message(kind, options = {})
    options[:scope] = "devise.#{controller_name}"
    options[:default] = Array(options[:default]).unshift(kind.to_sym)
    options[:resource_name] = resource_name
    options = devise_i18n_options(options) if respond_to?(:devise_i18n_options, true)
    I18n.t("#{options[:resource_name]}.#{kind}", options)
  end

end
