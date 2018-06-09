FactoryBot.define do

  factory :wiki do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    user

    trait :private do
      private true
    end

    factory :private_wiki, traits: [:private]
  end
end
