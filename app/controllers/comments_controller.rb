class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    @comment.body = params[:comment][:body]
    @comment.creator = User.first # TODO avoid hard coding this
    @comment.post = @post

    @comment.save
    flash[:post] = "Your comment was added."
    redirect_to @post
  end

  def post_params
    params.require(:comments).permit(:body)
  end

end
