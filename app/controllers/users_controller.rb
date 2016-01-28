class UsersController < ApplicationController

  before_action :find_user, only: [ :edit, :update, :show ]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)

    if @user.save then
      flash[:success] = 'User has been successfuly registered'
      redirect_to root_path
    else
      flash[:danger] = 'Oops...'
      render 'new'
    end
  end

  def edit
  end
  def update
    if @user.update(user_params) then
      flash[:success] = 'Updated!'
      redirect_to articles_path
    else
      flash[:danger] = 'Oops..'
      render 'edit'
    end
  end

  def show
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 2)
  end


  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
  def user_params_except_pass
    params.require(:user).permit(:username)
  end
  def find_user
    @user = User.find(params[:id])
  end


end