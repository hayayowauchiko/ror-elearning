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

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
			    )
end

10.times do |n|
  title  = Faker::StarWars.character
  description = Faker::StarWars.quote
  Category.create!(title:  title,
               description: description
			    )
end

categories = Category.all
5.times do |n|
  categories.each do |category|
  	content  = Faker::Pokemon.unique.name
    category.words.create!(content: content)
  end
end

words = Word.all
words.each do |word|
num = rand(0..2)
  3.times do |n| #nは0から始まって、３回（rails上は0から始まって2まで）
    content  = Faker::Pokemon.move
    if (n == num)
      correct = true
    else
      correct = false
    end
  word.word_answers.create!(content: content, correct: correct)
  end
end


# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }


# まいくろぽすと
# users = User.order(:created_at).take(6) 
# 50.times do
#   content = Faker::Lorem.sentence(5)
#   users.each do |user|
#     user.microposts.create!(content: content)
#   end
# end