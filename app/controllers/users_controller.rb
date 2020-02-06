class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Scott's Blog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Successfully updated info"
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def edit
     @user = User.find(params[:id])
  end

private
  def user_params
    # we need to specify what fields we are permitting - concept called
    # whitelisting.  Prevent mass updating, by only allowing what we
    # permit
    params.require(:user).permit(:username,:email, :password)
  end
end
