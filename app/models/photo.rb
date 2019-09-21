# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :user
  has_many :photo_tags, dependent: :destroy
  has_many :tags, through: :photo_tags
  has_one_attached :avatar

  validates :title, presence: true
  validates :photo_address, presence: true

  def save_tags(save_tags)
    current_tags = tags.pluck(:tag_name) unless tags.nil?
    old_tags = current_tags - save_tags
    new_tags = save_tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      tags.delete Tag.find_by(tag_name: old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      photo_tag = Tag.find_or_create_by(tag_name: new_name)
      tags << photo_tag
    end
    end

  def self.search_word(keyword)
    if keyword.empty?
      all
    else
      tag = Photo.joins(:tags).where(['tags.tag_name LIKE ?', "%#{keyword}%"]).uniq
      word = Photo.where('photo_info LIKE ? OR photo_address LIKE ? OR title LIKE ?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%").uniq
      result = tag.concat(word).uniq
      end
  end

  def self.search_tag(keytag)
    if keytag.empty?
      all
    else
      photo = Photo.joins(:tags).where(['tags.tag_name LIKE ?', "%#{keytag}%"]).uniq
      end
  end
end
