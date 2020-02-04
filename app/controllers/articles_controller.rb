class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def new
    @article = Article.new
  end

  #edit
  def edit
    @article = Article.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    flash[:notice] = "Record Not Found"
    redirect_to new_article_path()
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = "Article deleted"
      redirect_to articles_path
    end
  end

  #create
  def create
    #render plain: params[:article].inspect
    # whitelist the
    @article = Article.new(article_params)
    #@article.save  # at this point, article is saved but
                   #nothing happens, so we need to show
    #redirect_to article_path(@article)
    if @article.save
      # display message
      flash[:notice] = "Article was created!"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  #show
  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end


end
