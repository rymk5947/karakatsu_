class Public::HomesController < ApplicationController
  def index
    @posts = Post.all
    @user = current_user # ここで@userを現在のユーザーに設定する例
    if params[:message].present?
      @posts = Post.search_for(params[:message], params[:method])
    end
  end
end
