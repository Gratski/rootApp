require 'pp'
class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

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

  def show
    @article = Article.find(params[:id])
  end


  private
    def article_params
      params.require(:article).permit(:title, :description)
      
    end
end