FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph }
    user { FactoryBot.create(:user) }
    commentable { FactoryBot.create(:project) }
    trait :with_news_item do
      after(:create) do |comment|
        FactoryBot.create(:news_item, user: comment.user, title: "New comment on #{comment.commentable_type} #{comment.commentable_id}", body: comment.body, news_itemable: comment.commentable, project: comment.commentable)
      end
    end
  end
end
