class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # methods are availalbe to controllers, but not to views
  # so we need to declare ones we want to use in views as helpers
  helper_method :current_user, :logged_in?

  def current_user
    # return this user if session user_id is stored, then fetch that users
    # from the database, making that user available in the view
    # also miinimize multiple hits to the #
    # ||= is like +=
    # @current_user = @current_user || user.find()...  so we simply return
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # to convert anything to boolean, use !!
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do this"
      redirect_to root_path
    end
  end


end
