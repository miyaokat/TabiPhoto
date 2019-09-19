class UsersController < ApplicationController
before_action :authenticate_user!
  def show
    #他のユーザーから見た場合のユーザーページ
    if params[:userid].present?
    @user = User.find(params[:userid])
    @photos = Photo.where(user_id: params[:userid])
    else
    #本人が見た場合のユーザーページ
  	@user = current_user
    @photos = Photo.where(user_id: current_user.id)
    end
  end

  def index
    #管理者以外の場合、本人のマイページに飛ばす
    if current_user.admin_flag == true
    @users = User.all
    else
      redirect_to users_show_path(current_user)
    end
  end

  def edit
    @user = User.find(params[:userid])
  end

  def update
  	@user = User.find(params[:userid])
    #ユーザーのフラグを切り替える
	  flag = params[:is_deleted]
      if flag == 'true'
        @user.update_attribute(:is_deleted, params[:is_deleted])
        #管理者でなければ退会時に自動的にログアウトする
          if current_user.admin_flag == false
            sign_out_and_redirect(current_user)
          else
            redirect_to users_index_path
          end
      elsif flag == 'false'
        @user.update_attribute(:is_deleted, params[:is_deleted])
        redirect_to users_index_path
      #ユーザー情報を編集する場合の処理
      else
          @user.update(user_params)
          redirect_to users_show_path(@user.id)
  	  end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :is_delete, :password )
  end
end
