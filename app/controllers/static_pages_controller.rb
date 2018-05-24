class StaticPagesController < ApplicationController
  def home
  	if logged_in?
        @lessons = Lesson.where(user_id: current_user.id)
    end
  end
end
