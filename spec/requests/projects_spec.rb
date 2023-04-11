require 'rails_helper'

RSpec.describe "Projects", type: :request do
  include Devise::Test::IntegrationHelpers
  describe "GET /projects" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:projects) { FactoryBot.create_list(:project,5) }

    context "when user is logged in" do
      before do
        sign_in user
        get projects_path
      end

      it "gets the page" do
        expect(response).to have_http_status(200)
      end

      it "displays the project names" do
        projects.each do |project|
          expect(CGI.unescapeHTML(response.body)).to include(project.name)
        end
      end

      it "displays the project status" do
        projects.each do |project|
          expect(CGI.unescapeHTML(response.body)).to include(project.status)
        end
      end

      it "displays the project description" do
        projects.each do |project|
          expect(CGI.unescapeHTML(response.body)).to include(project.description)
        end
      end
    end

    context "when user is not logged in" do
      before do
        get projects_path
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET /projects/:id" do
    context "when user is logged in" do
      let!(:user) { FactoryBot.create(:user) }
      let!(:project) { FactoryBot.create(:project) }
      let!(:news_items) { FactoryBot.create_list(:news_item, 5, project: project) }
      let!(:comments) { FactoryBot.create_list(:comment, 5, commentable: project) }

      before do
        sign_in user
        get project_path(project)
      end

      it "gets the page" do
        expect(response).to have_http_status(200)
      end

      it "displays the project name" do
        expect(CGI.unescapeHTML(response.body)).to include(project.name)
      end

      it "displays the project status" do
        expect(CGI.unescapeHTML(response.body)).to include(project.status)
      end

      it "displays the project description" do
        expect(CGI.unescapeHTML(response.body)).to include(project.description)
      end

      it "displays the project news items" do
        news_items.each do |news_item|
          expect(CGI.unescapeHTML(response.body)).to include(news_item.title)
          expect(CGI.unescapeHTML(response.body)).to include(news_item.body)
        end
      end

      it "displays the project comments" do
        comments.each do |comment|
          expect(CGI.unescapeHTML(response.body)).to include(comment.body)
        end
      end
    end
  end

  describe "POST /projects" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:project) { FactoryBot.create(:project) }

    context "when user is logged in" do
      before do
        sign_in user
      end

      it "creates a project" do
        expect {
          post projects_path, params: { project: { name: "Test Project", description: "This is a test project", status: "new" } }
        }.to change(Project, :count).by(1)
      end

      it "redirects to the project page" do
        post projects_path, params: { project: { name: "Test Project", description: "This is a test project", status: "new" } }
        expect(response).to redirect_to(project_path(Project.last))
      end
    end

    context "when user is not logged in" do
      it "does not create a project" do
        expect {
          post projects_path, params: { project: { name: "Test Project", description: "This is a test project", status: "new" } }
        }.to_not change(Project, :count)
      end

      it "redirects to the sign in page" do
        post projects_path, params: { project: { name: "Test Project", description: "This is a test project", status: "new" } }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
