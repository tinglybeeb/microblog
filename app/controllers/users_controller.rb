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
      flash[:success] = "Welcome, #{@user.username}!"
      redirect_to users_path
    else
      render 'new'
    end
  end
  
  def edit
    set_user 
  end
  
  def update
    set_user
    @user.update(user_params)
    if @user.update(user_params)
      flash[:success] = "Beeb successfully updated"
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end
  
  def show
    set_user
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