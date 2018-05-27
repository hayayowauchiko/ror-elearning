class Word < ApplicationRecord
  belongs_to :category
  has_many :word_answers, dependent: :destroy
  accepts_nested_attributes_for :word_answers
  has_many :lesson_words, dependent: :destroy

  def correct_answer
  self.word_answers.where(correct: true).first #１つしかないから
  end

end
