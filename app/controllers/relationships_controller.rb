class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user_url(user)
  end
  def destroy
    user = Relationship.find(params[:id]).followed
    #Relationship.find(params[:id]).delete と同じ意味だが、
    #unfollowメソッドをfollowメソッドに対して作成しているので、作っている。
    current_user.unfollow(user)
    redirect_to user_url(user)
  end
end

