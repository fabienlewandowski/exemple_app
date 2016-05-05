module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at])
  devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at]) 
#    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at) }
#    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at) }
  end

end

DeviseController.send :include, DevisePermittedParameters
