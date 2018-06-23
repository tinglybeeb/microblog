class SessionsController < ApplicationController
  
  # renders the login form
  def new
  end
  
  # handles the login form submission
  def create
    # find the user based on email in params from post action. Downcase as all emails are downcased in database.
    user = User.find_by(email: params[:session][:email].downcase)
    # is user returned valid? If so, authenticate (.authenticate comes from bcrypt gem. Checks if the password matches.)
    if user && user.authenticate(params[:session][:password])
      # Save the user id in the session's hash (add a :user_id key & save the current user's id as the value)
      session[:user_id] = user.id
      # show success message & redirect to the logged in user's profile page
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    # If either is false, then show fail message and render the login page again
    else
      flash.now[:danger] = "There was something wrong with your login info"
      render 'new'
    end
  end
  
  # logs the user out / destroys the session
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end