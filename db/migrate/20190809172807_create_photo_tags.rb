# frozen_string_literal: true

class CreatePhotoTags < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_tags do |t|
      t.integer :photo_id
      t.integer :tag_id

      t.timestamps
    end
  end
end
