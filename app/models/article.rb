class Article < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :description, presence: true, length: {minimum: 3, maximum: 500}
  validates :user, presence: true
  
  # image upload
  mount_uploader :image, ImageUploader
end