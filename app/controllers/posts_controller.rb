class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @like = Like.new
  end

  def new
    @user = current_user
    @post = Post.new
  end

  def create
    @user = current_user
    @post = @current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to user_posts_path(@user.id) }
      else
        format.html { render :new }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
