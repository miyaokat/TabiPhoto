class PhotosController < ApplicationController
before_action :authenticate_user!, except: [:index, :show]
  def new
  	@photo = Photo.new
  end

  def index
  	@user = current_user
    @photos = Photo.all
    #キーワード、あるいはタグがあれば対応した条件で絞り込み、なければ全ての写真を渡す
  	if params[:keytag].present?
  	@photos = Photo.reverse_order.search_tag(params[:keytag])
  	elsif params[:keyword].present?
      @photos = Photo.reverse_order.search_word(params[:keyword])
    else
  	@photos = Photo.all.reverse_order
  	end
    @photos = Kaminari.paginate_array(@photos).page(params[:page]).per(20)
  end

  def show
  	@photo = Photo.find(params[:id])
  	@user = User.find(@photo.user_id)
  end

  def create
  	@photo = Photo.new(photo_params)
  	@photo.user_id = current_user.id
  	if@photo.avatar.attached?
      @photo.save
  	#カンマや全角スペーズを全て半角に置き換え、タグを分割する
  	tag_list = params[:tag_name].gsub(/[\s　]/," ").gsub(","," ").split(" ")
  	@photo.save_tags(tag_list)
  	redirect_to photos_path
    else
      flash.now[:notice] = "入力情報に不備があります。"
      render :new
    end
  end

  def edit
  	@photo = Photo.find(params[:id])
  end

  def update
  	@photo = Photo.find(params[:id])
  	tag_list = params[:tag_name].gsub(/[\s　]/," ").gsub(","," ").split(" ")
  	@photo.save_tags(tag_list)
  	if @photo.update(photo_params)
      flash[:notice] = "写真情報を更新しました。"
      redirect_to photo_path(@photo.id)
    else
      flash[:notice] = "写真の更新に失敗しました。"
      redirect_to photos_path
    end
  end

  def destroy
  	@photo = Photo.find(params[:id])
  	if @photo.destroy
      flash[:notice] = "写真を削除しました。"
      redirect_to photos_path
    else
      flash[:notice] = "写真の削除に失敗しました。"
      redirect_to photos_path
    end
  end

  protected
  def photo_params
  	params.require(:photo).permit(:title, :avatar, :user_id, :photo_info, :public_flag, :photo_address, :photo_prefecture)
  end
end
