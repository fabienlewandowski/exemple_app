class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
	@titre = "Inscription"
  end

  def create
    # Using params[:user] without calling user_params will throw an error because 
    # the parameters were not filtered. This is just some Rails magic.
    @user = User.new user_params
    if @user.save
      # Do whatever
    else
      render action: :new
    end
  end

  private
  def user_params
    # params.require(:user) throws an error if params[:user] is nil

    if current_user.nil? # Guest
      # Remove all keys from params[:user] except :name, :email, :password, and :password_confirmation
      params.require(:user).permit :nom, :email
    elsif current_user.has_role :admin
      params.require(:user).permit! # Allow all user parameters
    elsif current_user.has_role :user
      params.require(:user).permit :nom, :email
    end
  end
end
