class PostsController < ApplicationController

  def index
    if current_user
      @user = User.find_by(id: current_user.id)
      @posts = Post.all
    else
      redirect_to "/users/sign_in", notice: "ログインしてください"
    end
  end

  def show
    @post = Post.find(params[:id])
    @selected_genre = Post.find(params[:id]).genre
  end

  def new
    @posts = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to user_path(post.user), notice: "投稿を削除しました。"
  end

  private
    def post_params
      params.require(:post).permit(:genre, :message, :photo)
    end
end
