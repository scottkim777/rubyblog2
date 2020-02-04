class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
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
  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params.require(:article).permit(:title, :description)
  end


end
