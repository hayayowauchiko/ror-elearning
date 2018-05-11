class User < ApplicationRecord
  #databaseに保存せずにgetとsetを行う
  attr_accessor :remember_token
  #def name は@name, def name(引数) @name = name user.remember_tokenでアクセスできるようになる。
  #DBに格納する訳ではないので、attr_accssorを使う

  has_many :active_relationships, class_name:  "Relationship",
                                 foreign_key: "follower_id",
                                 dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy

  has_many :followers, through: :passive_relationships

  has_many :lessons, dependent: :destroy

  has_many :activities, dependent: :destroy

  before_save :downcase_email #{ email.downcase! }  #callback #before_save {self.email = email.downcase}

  validates :name, presence: true, length: {minimum: 5}

  has_secure_password
    validates :password,
                        length: {minimum: 6},
                        allow_nil: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # emailを正規表現を使ってvalidates
  validates :email,
                  presence: true,
                  length: {minimum: 5},
                  format: {with: VALID_EMAIL_REGEX}, #上で定義したvalidを使う
                  uniqueness: {case_sensitive: false} #大文字も小文字も同じ内容と認識する

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  #永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token #仮想上でのuserのremember_token collumnに値を代入
    update_attribute(:remember_digest, User.digest(remember_token)) #代入したremember_tokenを文字列としてUser.digestに渡す
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    if remember_digest.nil?
      false
    else
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end


  private
  def downcase_email
    email.downcase! #末尾に!をつける事でuser.emailに対しての代入も同時に果たしてくれる
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  #渡された文字列のハッシュ値を返す
  def User.digest(remember_token)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(remember_token, cost: cost)
  end
end




