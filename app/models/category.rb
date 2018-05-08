class Category < ApplicationRecord
    has_many :words

    validates :title, presence: true, length: {minimum: 5}
    validates :description, presence: true, length: {minimum: 10}


end
