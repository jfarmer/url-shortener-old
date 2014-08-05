# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    url { Faker::Internet.url }

    trait :with_user do
      user
    end

    factory :link_with_user, traits: [:with_user]
  end
end
