class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password]) # If there is a user, if not short circuit.
      session[:user_id] = user.id                   # don't save object because it takes up too much space.
      flash[:notice] = "Welcome #{user.username}! You're logged in."
      redirect_to root_path
    else
      flash.now[:error] = "Incorrect username or password. Please try again."
      render :new
    end
  end

  def destroy 
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end
end