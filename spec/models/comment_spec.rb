require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it "should have a valid factory" do
      expect(FactoryBot.build(:comment)).to be_valid
    end
    it "should require a body" do
      expect(FactoryBot.build(:comment, body: nil)).not_to be_valid
    end
    it "should require a body of at least 10 characters" do
      expect(FactoryBot.build(:comment, body: "123456789")).not_to be_valid
    end
    it "should require a user_id" do
      expect(FactoryBot.build(:comment, user_id: nil)).not_to be_valid
    end
    it "should require a user_id of an integer" do
      expect(FactoryBot.build(:comment, user_id: "abc")).not_to be_valid
    end
    it "should require a commentable_id" do
      expect(FactoryBot.build(:comment, commentable_id: nil)).not_to be_valid
    end
    it "should require a commentable_id of an integer" do
      expect(FactoryBot.build(:comment, commentable_id: "abc")).not_to be_valid
    end
    it "should require a commentable_type" do
      expect(FactoryBot.build(:comment, commentable_type: nil)).not_to be_valid
    end
    # it "should require a commentable_type of 'Project'" do
    #   expect(FactoryBot.build(:comment, commentable_type: "abc")).not_to be_valid
    # end
  end

  describe "associations" do
    it "should belong to a user" do
      expect(FactoryBot.build(:comment)).to respond_to(:user)
    end
    it "should belong to a commentable" do
      expect(FactoryBot.build(:comment)).to respond_to(:commentable)
    end
    it "should have many news items" do
      expect(FactoryBot.build(:comment)).to respond_to(:news_items)
    end
  end

  describe "methods" do
    describe "create_news_item" do
      let!(:comment) { FactoryBot.create(:comment, :with_news_item) }
      it "should create a news item" do
        expect(Comment.last.news_items.count).to eq(1)
      end
    end

  end

  describe "callbacks" do
    describe "after_create" do
      let!(:comment) { FactoryBot.create(:comment) }
      it "should create a news item" do
        expect(Comment.last.news_items.count).to eq(1)
      end
    end
  end
end
