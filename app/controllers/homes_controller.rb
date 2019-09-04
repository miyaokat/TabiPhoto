class HomesController < ApplicationController
  def top
  	#MYSQLで実施する場合RANDに書き換えること
  	@photos = Photo.where(public_flag: true).order("RANDOM()").limit(10)
  end
end
