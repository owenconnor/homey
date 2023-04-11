FactoryBot.define do
  factory :project do
    name { Faker::Commerce.department(max: 2)}
    description { Faker::Lorem.paragraph }
    status { Project::VALID_STATUSES.first }
    trait :with_comments do
      after(:create) do |project|
        FactoryBot.create(:comment,
                          commentable: project)
      end
    end
    trait :with_updates do
      after(:create) do |project|
        project.update(status: Project::VALID_STATUSES.second )
        FactoryBot.create(:news_item,
                          project: project,
                          title: "Project #{project.id} status update",
                          body: "Project #{project.id} status changed to #{project.status}",
                          news_itemable: project,
                          user_id: FactoryBot.create(:user).id)
      end
    end
  end
end
