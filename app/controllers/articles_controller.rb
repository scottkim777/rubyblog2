class ArticlesController < ApplicationController
  # call set_article method before actions, only for actions
  # specified by only:
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_owner, only: [:edit, :update, :destroy]

  #alias_method :select_for_count_with_relation, :select_for_count
  #remove_method :select_for_count

  def index
    #@articles = Article.all
    #@articles = Article.paginate(page: params[:page]) #, per_page: 5)
    @articles = Article.paginate(page: params[:page], per_page: 5)

  end
  def new
    @article = Article.new
    #@article = user.article.build
  end

  #edit
  def edit
    # @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    flash[:danger] = "Record Not Found"
    redirect_to new_article_path()
  end

  def update
    # @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:success] = "Article was updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    # @article = Article.find(params[:id])
    if @article.destroy
      flash[:warning] = "Article deleted"
      redirect_to articles_path
    end
  end

  #create
  def create
    #render plain: params[:article].inspect
    # whitelist the

    # for debugging we just enter debugger without the comment
    # debugger
    @article = Article.new(article_params)
    # temp
    #@article.user_id = 7

    #@article.save  # at this point, article is saved but
                   #nothing happens, so we need to show
    #redirect_to article_path(@article)
    if @article.save
      # display message
      flash[:success] = "Article was created!"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  #show
  def show
    #@article = Article.find(params[:id])
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end
  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_owner
    if current_user != @article.user
      flash[:danger] = "You can only edit you own"
      redirect_to root_path
    end
  end

end
