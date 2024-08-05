class PostsController < ApplicationController
   before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
    @user = current_user # ここで@userを現在のユーザーに設定する例
    if params[:message].present?
      @posts = Post.search_for(params[:message], params[:method])
    end
  end

  def show
    @post = Post.find(params[:id])
    @selected_genre = Post.find(params[:id]).genre
    @post_comment = @post.post_comments.new
    @user = User.find(params[:id])
  end

  def new
    @posts = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "投稿しました。"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
        redirect_to posts_path, alert: "不正なアクセスです。"
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "更新しました。"
    else
      render :edit
    end
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

