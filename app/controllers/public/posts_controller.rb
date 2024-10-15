class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
    if params[:message].present?
      @posts = Post.search_for(params[:message], params[:method])
    end
    @post_comment = PostComment.new
    @post = @posts.first
  end

  def favorites
    @post = Post.find(params[:id])
    @favorited_users = @post.favorited_users
  end

  def show
    @post = Post.find(params[:id])
    @selected_genre = Post.find(params[:id]).genre
    @post_comment = PostComment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post, notice: '投稿が成功しました。'
    else
      render :new # エラー時に新規投稿フォームを再表示
    end
  end

  def edit
    if @post.user != current_user
        redirect_to posts_path, alert: "不正なアクセスです。"
    end
  end

  def update
    @post = Post.find(params[:id])
  # チェックボックスがチェックされている場合は画像を削除
    if params[:post][:_destroy] == "1" && @post.photo.attached?
      @post.photo.purge
    end

    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(@post.user), notice: "投稿を削除しました。"
  end

  def user_posts
    @user = User.find(params[:id])
    @posts = @user.posts
  end


  private

  def post_params
    params.require(:post).permit(:genre, :message, :photo, photos_attributes: [:id, :_destroy])
  end

  def correct_user
    @post = current_user.posts.find_by_id(params[:id])
    redirect_to root_path unless @post
  end
end

