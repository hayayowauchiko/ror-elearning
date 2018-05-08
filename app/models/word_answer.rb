class WordAnswer < ApplicationRecord
    belongs_to :word
    belongs_to :lesson_word

end
