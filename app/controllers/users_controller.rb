class UsersController < ApplicationController
  before_action :set_user, only: [:show, :profile, :edit_account, :update_account, :edit_profile, :update_profile]
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit_account
    @user = User.find(params[:id])
  end

  def update_account
    if @user.update(account_params)
      redirect_to user_path(@user), notice: 'アカウントを更新しました'
    else
      render :edit_account
    end
  end

  def edit_profile
    @user = User.find(params[:id])
  end

  def update_profile
    if @user.update(profile_params)
      redirect_to user_path(@user), notice: 'プロフィールを更新しました'
    else
      render :edit_profile
    end
  end

  def set_user
     @user = User.find(params[:id])
  end

  def my_rooms
    @rooms = current_user.rooms
    puts "================ rooms: #{@rooms.inspect}"
  end

end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    unless @user
    redirect_to root_path, alert: 'ユーザーが見つかりません' 
    end
  end

  def account_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:user).permit(:name, :avatar, :introduction, :email, :password, :password_confirmation)
  end
