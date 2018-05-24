class Category < ApplicationRecord
    has_many :words, dependent: :destroy
    has_many :lessons, dependent: :destroy
    has_many :users, through: :lessons
    mount_uploader :picture, CategoryPictureUploader
    validates :title, presence: true, length: {minimum: 5}
    validates :description, presence: true, length: {minimum: 10}
end
