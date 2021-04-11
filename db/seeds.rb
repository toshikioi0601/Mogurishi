# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "ダイビング大好き管理者",
            email: "sample@example.com",
            password:              "foobar",
            password_confirmation: "foobar",
            admin: true)

100.times do |n|
 name  = Faker::JapaneseMedia::OnePiece.character
 email = "sample-#{n+1}@example.com"
 password = "password"
 User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password)
end

10.times do |n|
  Divelog.create!(name: Faker::JapaneseMedia::OnePiece.location,
                  description: "すばらしいダイビングポイントです",
                  depth: 10.0,
                  water_temp: 20,
                  temp: 30,
                  weather: "晴れ",
                  visibility: 15,
                  reference: "http://sample.com",
                  popularity: 5,
                  dive_memo: "天気は悪かったが透明度がよかった！",
                  user_id: 1)
end
