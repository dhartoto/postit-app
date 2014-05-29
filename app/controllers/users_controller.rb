class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :user_access, only: [:edit, :update]

  def show
    @posts = Post.where(user_id: params[:id]).sort_by{|x| x.count_votes}.reverse
    @comments = Comment.where(user_id: params[:id]).sort_by{|x| x.count_votes}.reverse
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome #{@user.username}! You are now registered."
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Your profile has been updated.'
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def user_access
    if current_user != @user
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
