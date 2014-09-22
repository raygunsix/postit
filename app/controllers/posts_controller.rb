class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  before_filter :require_user, :only => [:create, :update, :edit, :new]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.first # TODO remove this hard coded value

    if @post.save
      flash[:notice] = "You post was saved."
      redirect_to @post
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "You post was updated."
      redirect_to @post
    else
      render :edit
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, :category_ids => [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
