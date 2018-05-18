class LessonWordsController < ApplicationController

  def show
    @lesson_word = LessonWord.find(params[:id])
  end
  def update
    @lesson_word = LessonWord.find(params[:id])
    if @lesson_word.update(word_answer_id: params[:word_answer_id])
        lesson = Lesson.find(params[:lesson_id])
        i = lesson.lesson_words.index(@lesson_word)
            unless @lesson_word == lesson.lesson_words.last
                redirect_to lesson_word_url(lesson_id: lesson.id, id: lesson.lesson_words[i + 1])
                #indexとする事で配列の番号をreturnする。最初の配列は0なので、id=1(first)の配列は0
            else
                lesson.update(result: lesson.correct_answers.count)
                redirect_to lesson_url(lesson)
            end
    end
  end
end


            #     result = 0
            #     lesson.lesson_words.each do |lesson_word|
            #       if lesson_word.word_answer.correct == true
            #         result += 1
            #       end
            #       lesson.update(result: result)
            #     end
            # end
