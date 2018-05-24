class LessonsController < ApplicationController
  def create
    category = Category.find(params[:category_id])
    lesson = current_user.lessons.new(category_id: category.id)

    if lesson.save
      category.words.each do |word|
        lesson.lesson_words.create(word_id: word.id)
      end
    end
    redirect_to lesson_word_url(lesson_id: lesson.id, id: lesson.lesson_words.first)
  end

  def show
    @lesson = Lesson.find(params[:id])
    @lesson_words = @lesson.lesson_words
  end

end
