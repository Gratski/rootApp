require 'pp'
class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  #PAGE LOAD
  def new
    @article = Article.new
  end

  #INDEX
  def index
    @articles = Article.paginate(page: params[:page], per_page: 5) 
  end

  #NEW ARTICLE
  def create
    #debugger - this is just to debug
    @article = Article.new(article_params)
    @article.user = current_user
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
      params.require(:article).permit(:title, :description, category_ids: [])
    end
    def require_same_user
      if current_user != @article.user and !current_user.admin?
        redirect_to root_path
      end
    end
end