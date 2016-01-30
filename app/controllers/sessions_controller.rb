class SessionsController < ApplicationController

  def new

  end

  def create
    #hipoteses para debugging
    #render 'new'    
    #debugger
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) then
      session[:user_id] = user.id
      flash[  :success] = 'Logged in'
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Login wrong... try again.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[  :success] = 'Logged out'
    redirect_to root_path
  end

end