class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
#before_action :authenticate_user!, :only => [:edit, :update, :destroy]

  # GET /resource/sign_up
   def new
     @titre = "Inscription"
     super
   end

  # POST /resource
#   def create
#     @user = User.new user_params
#     flash[:success] = "Bienvenue dans l'Application Exemple!"
#     super
#   end

  # GET /resource/edit
   def edit
     @titre = "Édition profil"
     super
   end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

=begin
  private

  def user_params
    # params.require(:user) throws an error if params[:user] is nil

    if current_user.nil? # Guest
      # Remove all keys from params[:user] except :name, :email, :password, and :password_confirmation
      params.require(:user).permit :name, :email, :password, :password_confirmation
    elsif current_user.has_role :admin
      params.require(:user).permit! # Allow all user parameters
    elsif current_user.has_role :user
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def sign_up_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
    end

  end
=end
	

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
