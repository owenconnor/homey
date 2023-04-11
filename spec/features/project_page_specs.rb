require 'rails_helper'

RSpec.feature "ProjectPages", type: :feature do
  include Devise::Test::IntegrationHelpers
  let!(:user) { FactoryBot.create(:user) }
  let!(:project) { FactoryBot.create(:project) }
  let!(:news_items) { FactoryBot.create_list(:news_item, 5, project: project) }
  let!(:comments) { FactoryBot.create_list(:comment, 5, commentable: project) }

  describe "GET /projects/:id" do
    before do
      sign_in user
      visit project_path(project)
    end

    context "when user is logged in" do
      context "when adding a comment" do
        it "adds a comment" do
          fill_in "comment_body", with: "This is a new comment"
          click_button "Add Comment"
          expect(page).to have_content("Comment was successfully created.")
          expect(page).to have_content("This is a new comment")
        end
      end
      context "when updating project status" do
        it "updates the project status" do
          select "completed", from: "project_status"
          click_button "Update Project"
          expect(page).to have_content("Successfully updated project.")
          expect(page).to have_content("complete")
        end
      end
    end
  end
end