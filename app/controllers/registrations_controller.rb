class RegistrationsController < Devise::RegistrationsController
  layout "layouts/application_body_only"

  def set_flash_message(key, kind, options={})
    options.merge!  email:              resource.email,
                    unconfirmed_email:  resource.unconfirmed_email,
                    first_name:         resource.first_name,
                    last_name:          resource.last_name
    super key, kind, options
  end
end
