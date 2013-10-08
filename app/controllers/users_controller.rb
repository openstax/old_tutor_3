class UsersController < ApplicationController

  layout "layouts/application_body_only"

  skip_before_filter :require_registration!, only: [:registration, :register]
  skip_before_filter :require_agreement_to_terms!, only: [:registration, :register]

  def register
    handle_with(UsersRegister,
                success: lambda { redirect_to root_path },
                failure: lambda { render 'registration' })
  end
end
