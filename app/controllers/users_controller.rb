class UsersController < ApplicationController

  layout "layouts/application_body_only"

  skip_before_filter :authenticate_user!, only: [:become]
  skip_before_filter :require_registration!, only: [:registration, :register, :become]
  skip_before_filter :require_agreement_to_terms!, only: [:registration, :register, :become]

  def register
    handle_with(UsersRegister,
                success: lambda { redirect_to root_path },
                failure: lambda { render 'registration' })
  end

  def become
    raise SecurityTransgression unless !Rails.env.production? || current_user.is_administrator?
    sign_in(User.find(params[:id]))
    redirect_to request.referrer
  end
end
