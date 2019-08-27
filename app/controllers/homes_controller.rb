class HomesController < ApplicationController
  def top
  	@photos = Photo.where(public_flag: true).order("RANDOM()").limit(10)
  end
end
