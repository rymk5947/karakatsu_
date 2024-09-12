class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit]

  def create
    user = User.new(user_params)
    if user.save
     redirect_to root_path, notice: "ユーザー登録が完了しました。"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    if params[:name].present?
      @users = User.search_for(params[:name], params[:method])
    end
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  def favorites
    @user = User.find(params[:id])
    @favorite_posts = @user.favorite_posts
    @post = Post.new
    @post_comment = PostComment.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:commit] == "削除する"
      @user.profile_image.purge if @user.profile_image.attached?
      redirect_to user_path(@user), notice: "画像を削除しました。"
    elsif @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to :root 
  end


  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path, notice: "guestuserでログインしました。"
  end

  private
  def user_params
    params.require(:user).permit(:name, :age, :sex, :introduction, :email, :password, :password_confirmation, :profile_image)
  end

  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to root_path unless current_user == @user
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end