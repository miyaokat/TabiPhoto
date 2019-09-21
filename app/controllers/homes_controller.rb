# frozen_string_literal: true

class HomesController < ApplicationController
  def top
    target_ids = Photo.where(public_flag: true).sample(10)
    @photos = Photo.where(id: target_ids)
  end
end
