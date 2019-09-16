FactoryBot.define do
  # Photoモデルのテストデータを定義
  	factory :testphoto, class: Photo do
      avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'sample.png'), 'png'), 'image/png' }
  		user_id {1}
  		title {"sample"}
  		photo_info {"contoller_test"}
  		photo_address {"神奈川県"}
  		public_flag {true}
  		latitude {35.681236}
  		longitude {139.767125}
  	end
 end