class Category < ApplicationRecord
    has_many :words, dependent: :destroy

    validates :title, presence: true, length: {minimum: 5}
    validates :description, presence: true, length: {minimum: 10}


end
