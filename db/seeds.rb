# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "seedの実行を開始"

# タグの作成
["生活・人間関係", "仕事・学業", "心の悩み", "健康・体調", "その他"].each do |name|
  Tag.find_or_create_by!(name: name)
end

# タグの取得
school_tag = Tag.find_by!(name: "仕事・学業")
family_tag = Tag.find_by!(name: "生活・人間関係")
work_tag   = Tag.find_by!(name: "心の悩み")

# ユーザー作成
olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
  user.name = "Olivia"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

james = User.find_or_create_by!(email: "james@example.com") do |user|
  user.name = "James"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
  user.name = "Lucas"
  user.password = "password"
  user.profile_image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

# Room の作成とタグの割り当て
Room.find_or_create_by!(title: "学校に行きたくないです") do |room|
  room.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename: "sample-post1.jpg")
  room.body = "理由はありませんなんとなくです"
  room.user = olivia
  room.tag = school_tag
end

Room.find_or_create_by!(title: "家族仲が") do |room|
  room.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename: "sample-post2.jpg")
  room.body = "子供が絶賛反抗期になってしまいました！"
  room.user = james
  room.tag = family_tag
end

Room.find_or_create_by!(title: "職場環境が") do |room|
  room.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename: "sample-post3.jpg")
  room.body = "職場でうまくいかなくて困っています"
  room.user = lucas
  room.tag = work_tag
end

puts "コメントの作成を開始"

room1 = Room.find_by!(title: "学校に行きたくないです")
room2 = Room.find_by!(title: "家族仲が")
room3 = Room.find_by!(title: "職場環境が")

Comment.find_or_create_by!(body: "私も以前、なんとなく学校に行きたくない時期がありました。少し休んで、自分の好きなことに集中してみたら気持ちが落ち着きましたよ。無理しないでくださいね。", user: james, room: room1)
Comment.find_or_create_by!(body: "うちの子も反抗期の時は話しかけるたびにぶつかっていました。私は、まず話す時間を短くして、共通の趣味（ゲームや映画など）を通じて少しずつ距離を縮めるようにしました。少し時間がかかりますが、変化はありますよ。", user: lucas, room: room2)
Comment.find_or_create_by!(body: "以前の職場で上司との関係に悩んでいた時、信頼できる同僚に相談したり、日記を書いて気持ちを整理したりしていました。状況が改善しなければ、転職も一つの選択肢として真剣に考えてみてください。", user: olivia, room: room3)

puts "コメントの作成が完了しました"

puts "seedの実行が完了しました"