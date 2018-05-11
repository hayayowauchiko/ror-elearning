module SessionsHelper
  #渡されたユーザーでログイン。user.idをセッションに保存する
  def log_in(user)
    session[:user_id] = user.id
  end
  # ユーザーのセッションを永続的にする
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
    #しかし記憶トークンがなければ、暗号化されたIDを奪った攻撃者は、
    #暗号化IDをそのまま使ってお構いなしにログインしてしまうでしょう。
    #現在の設計では、攻撃者が仮に両方のcookiesを奪い取ることに成功したとしても、本物のユーザーがログアウトするとログインできないようになっています。
  end

  #現在ログイン中のユーザーを返す（いる場合）
  #既に@current_userを発行していればそれを代入するし、なければfind_byする。結果nilが入る可能性もある
  # 記憶トークンcookieに対応するユーザーを返す
  def current_user
    if (user_id = session[:user_id]) #sessionの中にuser_idがいたら代入する
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id]) #cookieにuser_idがいたら代入する
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  #ユーザーがログインしていればtrue,その他ならfalse
  #nilじゃないよね？と聞いている。nilでなければtrue
  def logged_in?
    !current_user.nil?
  end
  #現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil #@current_userにはsessionではなくてuser_idが入っているため削除する必要がある。
  end

  # 永続的セッションを破棄する
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  # 現在のユーザーをログアウトする
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end


#@current_user = nilに関して

# リダイレクトを直接発行しなかった場合だけです。
# 今回はリダイレクトを直接発行しているので、不要です。
# 現実にこのような条件が発生する可能性はかなり低く、
#このアプリケーションでもこのような条件を作り出さないように開発しているので、本来はnilに設定する必要はないのですが、
#ここではセキュリティ上の死角を万が一にでも作り出さないためにあえてnilに設定しています。
#ajaxでは残るけど,redirectではサーバーサイドの話。
#