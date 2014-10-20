class CommentsController < ApplicationController
  before_filter :require_user, :only => [:create, :vote]

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @comment.body = params[:comment][:body]
    @comment.creator = current_user
    @comment.post = @post

    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to @post
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.new(vote: params[:vote], creator: current_user, voteable: @comment)
    if @vote.save
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "Your vote was not counted. Please try again."
    end
    redirect_to :back
  end

  def post_params
    params.require(:comments).permit(:body)
  end

end
