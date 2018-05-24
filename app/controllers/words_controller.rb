class WordsController < ApplicationController
  def index
    @lessons = Lesson.where(user_id: current_user.id)
    @user = User.find(current_user.id)
    @words = @user.words.paginate(page: params[:page], per_page: 10)
  end
end
