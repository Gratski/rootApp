require 'pp'
class ArticlesController < ApplicationController
  
  #PAGE LOAD
  def new
    @article = Article.new
  end

  #INDEX
  def index
    @articles = Article.all
  end

  #NEW ARTICLE
  def create
    @article = Article.new(article_params)
    if @article.save then
      #good
      flash[:notice] = "article was successfully created"
      redirect_to article_path(@article)
    else
      #not good
      flash[:erro] = 'ups...'
      render 'new'
    end
  end

  #SHOW ARTICLE
  def show
    @article = Article.find(params[:id])
  end

  #EDIT
  def edit
    @article = Article.find(params[:id])
  end

  #UPDATE
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params) then
      flash[:notice] = 'Successfully updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  #DELETE
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "The article was successfully deleted"
    redirect_to articles_path
  end


  private
    def article_params
      params.require(:article).permit(:title, :description)
      
    end
end