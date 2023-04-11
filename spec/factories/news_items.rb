FactoryBot.define do
  factory :news_item do
    title { Faker::Lorem.sentence(word_count: 4) }
    user { FactoryBot.create(:user) }
    project { FactoryBot.create(:project) }
    body { Faker::Lorem.paragraph(sentence_count: 2) }
    news_itemable { FactoryBot.create(:comment) }
  end
  # trait :for_comment do
  #   user { FactoryBot.create(:user) }
  #   project { FactoryBot.create(:project) }
  #   body { Faker::Lorem.paragraph(20) }
  #   news_itemable { FactoryBot.create(:comment) }
  # end
end
