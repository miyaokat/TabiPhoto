class PhotosController < ApplicationController
  def new
  	@photo = Photo.new
  end

  def index
  	@photos = Photo.all
  end

  def show
  	@photo = Photo.find(params[:id])
  end

  def create
  	@photo = Photo.new(params)
  	@photo.save
  end

  def edit
  end

  def photo_params
  	params.require(:photo).permit(:title, :photo_info, :image_id, :photo_address, :public_flag)
end
