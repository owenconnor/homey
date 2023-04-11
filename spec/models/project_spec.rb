require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { Project.new(name: "Test Project", description: "This is a test project", status: "new") }
  describe "validations" do
    it "is valid with valid attributes" do
      expect(project).to be_valid
    end

    it "is not valid without a name" do
      project.name = nil
      expect(project).to_not be_valid
    end

    it "is not valid without a description" do
      project.description = nil
      expect(project).to_not be_valid
    end

    it "is not valid without a status" do
      project.status = nil
      expect(project).to_not be_valid
    end

    it "is not valid with a status that is not in the list of valid statuses" do
      project.status = "invalid"
      expect(project).to_not be_valid
    end
  end

  describe "#create_news_item" do
    it "creates a news item" do
      project.save
      project.status = "completed"
      project.create_news_item(FactoryBot.create(:user))
      expect(NewsItem.count).to eq(1)
    end
  end

end
