require 'pp'
class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]


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
      flash[:success] = "article was successfully created"
      redirect_to article_path(@article)
    else
      #not good
      flash[:danger] = 'ups...'
      render 'new'
    end
  end

  #SHOW ARTICLE
  def show
  end

  #EDIT
  def edit
  end

  #UPDATE
  def update
    if @article.update(article_params) then
      flash[:success] = 'Successfully updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  #DELETE
  def destroy
    @article.destroy
    flash[:success] = "The article was successfully deleted"
    redirect_to articles_path
  end


  private
    def set_article
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :description)
      
    end
end