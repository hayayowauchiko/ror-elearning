class UsersController < ApplicationController
  before_action :logged_in_user, only:[:edit, :update, :index]
  before_action :correct_user, only:[:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.picture = "default_image.png"
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_url(@user)
    else
      render "new" #users/new と一緒
    end
  end

  def show
    @user = User.find(params[:id])

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      flash[:success] = "Profile Updated"
      redirect_to user_url(user)
    else
      render "edit"
    end
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :picture)
  end

  #before action
  #ログイン済みユーザーとそのユーザーが正しいユーザーか（編集・更新ページを同一人物以外が操作できないように操作）
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user) #current_userが@userとイコールでない場合はredirect
  end

end
#update_attributesメソッドはupdateメソッドのエイリアスですが、
#バリデーションを省略して単一属性を変更するupdate_attributeメソッドとの違いを明確にするために、
#筆者は長いメソッド名の方を好んで使っています