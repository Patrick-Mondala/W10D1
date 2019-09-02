FactoryBot.define do
  factory :user do
    #not actually an email
    username { Faker::Internet.email }
    password { 'whatever' }
  end
end