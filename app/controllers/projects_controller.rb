class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    Rails.logger.info "Current user: #{current_user.inspect}"
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @comments = @project.comments
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, :notice => "Successfully created project."
    else
      render :action => 'index'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_url, :notice => "Successfully destroyed project."
  end

  private
  def project_params
    params.require(:project).permit(:name, :description)
  end
end
