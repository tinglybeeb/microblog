class UsersController < ApplicationController
  
  before_action :set_user, only: [:edit, :update]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save

      # save the user's id into the session (so the user is now considered logged in for the session)
      session[:user_id] = @user.id
      
      flash[:success] = "Welcome, #{@user.username}!"
      redirect_to users_path(@user)
    else
      render 'new'
    end
  end
  
  def edit
    set_user
    # if the user isn't logged in or the logged in user is not the user in /users/id/edit, then don't allow the edit.
    if (logged_in? && current_user.id != @user.id) || !logged_in?
      flash[:danger] = "You cannot edit this user"
      redirect_to root_path
    end
  end
  
  def update
    set_user
    @user.update(user_params)
    if @user.update(user_params)
      flash[:success] = "Beeb successfully updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end
  
  def show
    set_user
    if !logged_in?
      flash[:danger] = "Log in first before you can view users!"
      redirect_to root_path
    end
  end
  
  private    
    # saves the user object indicated in the params (from route's URL path) in @user, so the controller actions can be performed on the correct user object
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end