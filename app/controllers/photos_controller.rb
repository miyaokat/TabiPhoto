class PhotosController < ApplicationController
  def new
  	@photo = Photo.new
  end

  def index
  	unless params[:keyword].blank?
  	@photos = Photo.search_tag(params[:keyword])
  	else
  	@photos = Photo.all
  	end
  end

  def show
  	@photo = Photo.find(params[:id])
  end

  def create
  	@photo = Photo.new(photo_params)
  	@photo.user_id = current_user.id
  	@photo.save

  	#カンマや全角スペーズを全て半角に置き換え、タグを分割する
  	tag_list = params[:tag_name].gsub(/[\s　]/," ").gsub(","," ").split(" ")
  	@photo.save_tags(tag_list)
  	redirect_to root_path
  end

  def edit
  end

  def photo_params
  	params.require(:photo).permit(:title, :avatar, :user_id, :photo_info, :public_flag, :photo_address)
  end
end
