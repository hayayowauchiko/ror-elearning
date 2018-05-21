# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

#ユーザー
# User.create!(name:  "Example User",
#              email: "example@railstutorial.org",
#              password:              "password",
#              password_confirmation: "password",
#              admin: true,
# 			 )

# categories = Category.all.take(3)
# 20.times do |n|
#   content  = Faker::Pokemon.unique.name
#   categories.each do |category|
#   	category.words.create!(content: content)
#   end
# end

words = Word.all
words.each do |word|
content  = Faker::Pokemon.move
3.times do |n|
	word.word_answers.create!(content: content, correct: num)

  num = Faker::

  end
end



# リレーションシップ
# users = User.all
# user  = users.first
# following = users[2..50]
# followers = users[3..40]
# following.each { |followed| user.follow(followed) }
# followers.each { |follower| follower.follow(user) }


# まいくろぽすと
# users = User.order(:created_at).take(6) 
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each do |user|
#     user.microposts.create!(content: content)
#   end
# end