class Word < ApplicationRecord
    belongs_to :category
    has_many :word_answers, dependent: :destroy
    has_many :lesson_words, dependent: :destroy
end
