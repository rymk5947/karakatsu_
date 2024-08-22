class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    user = User.new(user_params) # ストロングパラメーターを呼び出す
    if user.save# ユーザーを作成できた場合の処理
     redirect_to root_path, notice: "ユーザー登録が完了しました。"# 例えば、サインアップ成功メッセージを表示してリダイレクトするなど
    else  # ユーザーを作成できなかった場合の処理
     render :new# 例えば、エラーメッセージを表示して新規登録フォームを再表示するなど
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def followings
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
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
    redirect_to :root #削除に成功すればrootページに戻る
  end

  #def profile_image
    #@user = User.find(params[:id])
    #@user.profile_image.purge # 画像を削除する
  #end

  private
  def user_params
    params.require(:user).permit(:name, :age, :sex, :introduction, :email, :password, :password_confirmation, :profile_image)
  end

  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to root_path unless current_user == @user
  end
end