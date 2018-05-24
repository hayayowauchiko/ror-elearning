class LessonWord < ApplicationRecord
  belongs_to :lesson
  belongs_to :word
  belongs_to :word_answer, optional: true #optional: trueはword_anserがnillでもokという意味
end
