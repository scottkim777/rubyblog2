class UsersController < ApplicationController
  before_action :require_owner, only: [:edit, :update, :destroy]
  before_action :require_user, except: [:new, :create]
  before_action :require_admin, only: [:destroy]

  def index
    #@user = User.all
    @user = User.paginate(page: params[:page], per_page: 3)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    # set this user as being logged in after signing up
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to Scott's Blog #{@user.username}"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    #@articles = @user.articles

    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles have been deleted"
    redirect_to users_path
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

  def require_owner
    @user = User.find(params[:id])
    if current_user != @user and !current_user.admin?
      flash[:danger] = "You can only edit your account"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? and !current_user.admin?
      flash[:danger] = "Only admin user can delete"
      redirect_to root_path
    end
  end

end
