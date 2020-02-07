class SessionsController < ApplicationController
  # login
  def new
  end

  # logged in state
  def create
    #render "new"
    #debugger
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # save user id to sessions has which is saved in cookies
      session[:user_id] = user.id
      flash[:success] = "You have succesfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "There is something wrong with our info"
      render 'new'
    end
  end

  # logout
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
end
