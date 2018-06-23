class ApplicationController < ActionController::Base
  
  helper_method :current_user, :logged_in?
  
  # Gets and stores the logged in user object from the database (so any controller can use it later)
  def current_user
    # if session contains a user_id (we logged in and session isn't destroyed/user_id isn't removed)
    # And if there isn't a value for @current_user (we haven't assigned it a value). 
    # ^ This is to minimise redundant database queries if we've already returned the user.
    # Then return the user object
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  # Used to segment functionality based on logged in / logged out
  def logged_in?
    # Returns true if current_user returns anything. If not, return false.
    !!current_user
  end
  
  # Restrict certain actions based on whether there's a logged in user
  def require_user
     if !logged_in?
       flash[:danger] = "You must be logged in to perform that action"
       redirect_to login_path
     end
  end
  
end
