class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]

  def index
    @posts = Post.all.sort_by{|x| x.count_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new  
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "You post has been updated!"
      redirect_to post_path(@post)
    else
        render :edit
    end
  end

  def vote
    @post = Post.find_by(slug: params[:id])
    @vote = Vote.create(vote: params[:vote], user_id: current_user.id, voteable: @post)
    
    if !@vote.valid?
      flash[:error] = "You can only vote once per post."
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render 'vote'}
    end
  end

private
  def post_params
    params.require(:post).permit(:url, :title, :description, :slug, category_ids: [])
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end
end
