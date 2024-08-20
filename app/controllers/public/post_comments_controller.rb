class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save!
    redirect_back(fallback_location: root_path)
  end

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.post_comments # 関連付けの修正に合わせて修正しま
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
