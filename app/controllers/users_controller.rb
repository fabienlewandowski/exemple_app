class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :admin_user,   :only => :destroy
  protect_from_forgery

  def index
    @titre = "Tous les utilisateurs"
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @titre = @user.name
    unless @user == current_user
      redirect_to :root, :alert => "Accès refusé." 
    end
  end

  def new
        @user = User.new
	@titre = "Inscription"
  end

  def create
    # Using params[:user] without calling user_params will throw an error because 
    # the parameters were not filtered. This is just some Rails magic.
    @user = User.new user_params
    if @user.save
      flash[:success] = "Bienvenue dans l'Application Exemple!"
      redirect_to @user
    else
      @titre = "Inscription"
      render action: :new
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Utilisateur supprimé."
    redirect_to users_path
  end

  private

    def admin_user
      unless current_user.admin?
        flash[:error] = "Vous n'êtes pas admin!" 
        redirect_to(root_path)
      end
    end

  def user_params
    # params.require(:user) throws an error if params[:user] is nil

    if current_user.nil? # Guest
      # Remove all keys from params[:user] except :name, :email, :password, and :password_confirmation
      params.require(:user).permit :nom, :email, :password, :password_confirmation
    elsif current_user.has_role :admin
      params.require(:user).permit! # Allow all user parameters
    elsif current_user.has_role :user
      params.require(:user).permit :nom, :email, :password, :password_confirmation
    end
  end
end
