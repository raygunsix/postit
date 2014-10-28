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
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @comment)
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = "You can only vote on a comment once."
        end
        redirect_to :back
      end
      format.js
    end
  end

  def post_params
    params.require(:comments).permit(:body)
  end

end
