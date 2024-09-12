class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    @post_comment = post.post_comments.build

    if comment.save
      redirect_to posts_path(@post_comment.post)
    else
      flash.now[:alert] = "コメントの保存に失敗しました"
      @comments = post.post_comments
      @posts = Post.all
      render 'public/posts/index'
    end
  end

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.post_comments
    @post_comment = PostComment.new
    redirect_to posts_path(@post)
  end

  def show
    @post = Post.find(params[:id])
    @post_comments = @post.post_comments
    @current_user = current_user
  end


  def destroy
    @post_comment = PostComment.find_by(id: params[:id])
      if @post_comment && current_user == @post_comment.user
        @post_comment.destroy
        redirect_to posts_path, notice: "コメントを削除しました。"
      else
        redirect_to posts_path, notice: "削除に失敗しました。"
      end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
