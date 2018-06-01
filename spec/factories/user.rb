FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
end

FactoryBot.define do

  factory :user, :class => 'User' do
    email
    password '12345678'
    password_confirmation '12345678'

    trait :premium do
      role :premium
    end

    trait :admin do
      role :admin
    end

    factory :premium_user, traits: [:premium]
    factory :admin_user, traits: [:admin]
  end
end
