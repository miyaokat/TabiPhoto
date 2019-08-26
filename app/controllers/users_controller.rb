class UsersController < ApplicationController
before_action :authenticate_user!
  def show
  	@user = current_user
  end

  def index
  	@photos = Photo.where(user_id: current_user.id)
  	@photos = Kaminari.paginate_array(@photos).page(params[:page]).per(20)
  end

  def update
  	@user = User.find(current_user.id)
	flag = params[:is_deleted]
  	  	if flag == 'true'
  	  	@user.update_attribute(:is_deleted, params[:is_deleted])
  	  	sign_out_and_redirect(current_user)
  	  end
  end
end
