class HomesController < ApplicationController
  def top
  	@photos = Photo.where(public_flag: true).order("RANDOM()").limit(16)
  end
end
