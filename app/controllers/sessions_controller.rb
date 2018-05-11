class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
        #ユーザーログイン後にユーザー情報のページにリダイレクトする
        log_in(user)
        if params[:session][:remember_me] == '1'
          remember(user)
        else
          forget(user)
        end
        redirect_to user_url(user) #/users/user.id のget またはredirect_to user_url(user)と同じ
    else
        #エラーメッセージ
        flash.now[:danger] = "invalid email or password"
        render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end


end
