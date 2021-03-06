# frozen_string_literal: true

class AddLatitudeAndLongitudeToPhotos < ActiveRecord::Migration[5.2]
  def change
    add_column :photos, :latitude, :float
    add_column :photos, :longitude, :float
  end
end
