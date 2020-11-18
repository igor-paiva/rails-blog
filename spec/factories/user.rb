FactoryBot.define do
  factory :user, aliases: [:follower_user, :followed_user] do
    name { Faker::Internet.username(specifier: 4..15) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
