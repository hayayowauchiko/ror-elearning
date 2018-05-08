class User < ApplicationRecord

    has_many :active_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following, through: :active_relationships, source: :followed

    has_many :passive_relationships, class_name: "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
    has_many :followers, through: :passive_relationships

    has_many :lessons, dependent: :destroy


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
end
