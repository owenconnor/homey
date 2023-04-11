require 'rails_helper'

RSpec.describe NewsItem, type: :model do
  describe "validations" do
    it "should have a valid factory" do
      expect(FactoryBot.build(:news_item)).to be_valid
    end
    it "should require a title" do
      expect(FactoryBot.build(:news_item, title: nil)).not_to be_valid
    end
    it "should require a title of at least 5 characters" do
      expect(FactoryBot.build(:news_item, title: "1234")).not_to be_valid
    end
    it "should require a body" do
      expect(FactoryBot.build(:news_item, body: nil)).not_to be_valid
    end
    it "should require a body of at least 10 characters" do
      expect(FactoryBot.build(:news_item, body: "123456789")).not_to be_valid
    end
    it "should require a news_itemable_id" do
      expect(FactoryBot.build(:news_item, news_itemable_id: nil)).not_to be_valid
    end
    it "should require a news_itemable_id of an integer" do
      expect(FactoryBot.build(:news_item, news_itemable_id: "abc")).not_to be_valid
    end
    it "should require a news_itemable_type" do
      expect(FactoryBot.build(:news_item, news_itemable_type: nil)).not_to be_valid
    end
    it "should require a project_id" do
      expect(FactoryBot.build(:news_item, project_id: nil)).not_to be_valid
    end
    it "should require a project_id of an integer" do
      expect(FactoryBot.build(:news_item, project_id: "abc")).not_to be_valid
    end
    it "should require a user_id" do
      expect(FactoryBot.build(:news_item, user_id: nil)).not_to be_valid
    end
    it "should require a user_id of an integer" do
      expect(FactoryBot.build(:news_item, user_id: "abc")).not_to be_valid
    end

  end

  describe "associations" do
    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project) }
    let(:comment) { FactoryBot.create(:comment, user: user, commentable: project) }
    let(:news_item) { FactoryBot.build(:news_item, user: user, project: project, news_itemable: comment ) }
    it "should belong to a user" do
      expect(FactoryBot.build(:news_item)).to respond_to(:user)
    end
    it "should belong to a project" do
      expect(FactoryBot.build(:news_item)).to respond_to(:project)
    end
    it "should belong to a news_itemable" do
      expect(FactoryBot.build(:news_item)).to respond_to(:news_itemable)
    end

  end
end
