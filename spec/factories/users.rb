FactoryBot.define do
  # Userモデルのテストデータを定義
  factory :testuser , class: User do
    name { "testuser1" }
    email {"test@test.com"}
    password {"password"}
    password_confirmation {"password"}
  	end
 end