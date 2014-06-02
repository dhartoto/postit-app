class CommentsController < ApplicationController
  before_action :require_user, except: [:index, :show,]

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = Comment.new(set_comment)
    @comment.post = @post 
    @comment.creator = current_user
    @comments = @post.comments.all.sort_by{|x| x.count_votes}.reverse
    if @comment.save
      flash[:notice] = "Your comment has been posted"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @obj = Comment.find(params[:id])
    @vote = Vote.create(vote: params[:vote], voteable: @obj, creator: current_user)
    if !@vote.valid?
      flash[:error] = "You can only vote once per comment."
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js {render 'posts/vote'}
    end
  end

  private

  def set_comment
    params.require(:comment).permit(:body)
  end
end