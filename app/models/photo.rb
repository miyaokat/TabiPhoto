class Photo < ApplicationRecord
	belongs_to :user
	has_many :photo_tags, dependent: :destroy
	has_many :tags, through: :photo_tags
	has_one_attached :avatar
	geocoded_by :photo_address
	after_validation :geocode, if: lambda {|obj| obj.photo_address_changed?}
	
	def save_tags(save_tags)
	  current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
	  old_tags = current_tags - save_tags
	  new_tags = save_tags - current_tags

	  # Destroy old taggings:
	  old_tags.each do |old_name|
	  self.tags.delete Tag.find_by(tag_name:old_name)
	  end

	    # Create new taggings:
	  new_tags.each do |new_name|
	  photo_tag = Tag.find_or_create_by(tag_name:new_name)
	  self.tags << photo_tag
      end
    end

    def self.search_tag(keyword)
    unless keyword.empty?
     photo = Photo.joins(:tags).where(['tags.tag_name LIKE ?', "%#{keyword}%"]).uniq
   	else
     all
   	end
    end

end
