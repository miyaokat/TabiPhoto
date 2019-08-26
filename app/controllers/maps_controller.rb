class MapsController < ApplicationController
  before_action :authenticate_user!
  def show
  	#indexアクションから渡された県名で、どの県の情報を表示するか判断している
  	@mphotos = Photo.where(user_id: current_user.id).where(['photo_prefecture LIKE ?', "%#{@@prefecture}%"]).uniq
  	gon.photoInfo = @mphotos

  	@viewphotos = Photo.where(user_id: current_user.id).where(['photo_prefecture LIKE ?', "%#{@@prefecture}%"]).page(params[:page]).per(3)

  	#都道府県の緯度経度を取得
  	map = Geocoder.coordinates("#{@@prefecture}")
  	gon.lat, gon.lng = map

  end

  def index
  	@mphotos = nil
  	@photos = Photo.where(user_id: current_user.id)
  	#そのユーザーの投稿済み写真から住所を抜き出す
  	gon.user_photos = Photo.where(user_id: current_user.id).pluck(:photo_prefecture)

  	#ビューから渡ってきた、県名を確認
  	unless params[:prefecture].blank?
  		@@prefecture = params[:prefecture]
  		render:js => "window.location = '/maps/show'"
  	else
  		@mphotos = nil
  	end
  end
end
