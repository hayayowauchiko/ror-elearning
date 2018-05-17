class Relationship < ApplicationRecord

    belongs_to :follower, class_name: "User"
    #follower_idカラムとUserのicカラムが一緒という事を示している
    #関連名から関連相手のオブジェクト名を生成できない事情がある場合、
    #:class_nameオプションを使用してモデル名を直接指定できます。
    #relationshipがfollowerに従属しているが実際のモデル名がUserである場合
    belongs_to :followed, class_name: "User"
    validates :follower_id, presence: true
    validates :followed_id, presence: true

end