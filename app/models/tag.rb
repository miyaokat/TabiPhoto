class Tag < ApplicationRecord
	has_many :photo_tags, dependent: :destroy
end
