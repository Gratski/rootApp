class UsersController < ApplicationController
  before_action :find_user, only: [ :edit, :update, :show ]
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
    @user = User.new
  end
  def create
    @user = User.new(user_params)

    if @user.save then
      flash[:success] = 'User has been successfuly registered'
      session[:user_id] = @user.id
      redirect_to user_path(@user)
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

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:success] = 'User deleted'
      redirect_to users_path
    else
      flash[:warning] = 'Something went wrong...'
      redirect_to users_path
    end
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
  def require_same_user
    if current_user != @user && !current_user.admin?
      redirect_to root_path
    end
  end
  def require_admin
    if !current_user.admin?
      redirect_to root_path
    end
  end

end