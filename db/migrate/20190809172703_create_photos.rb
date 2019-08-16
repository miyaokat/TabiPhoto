class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :title
      t.text :photo_info
      t.string :photo_address
      t.boolean :public_flag

      t.timestamps
    end
  end
end
