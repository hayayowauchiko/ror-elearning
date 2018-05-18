class StaticPagesController < ApplicationController
  def home
        @lessons = Lesson.where(user_id: current_user.id)
  end
end
