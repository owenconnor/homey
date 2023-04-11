class CommentsController < ApplicationController
  before_action :set_project, only: [:create, :destroy]

  def create
    @comment = @project.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment was successfully created."
      redirect_to @project, notice: "Comment was successfully created."
    else
      flash[:alert] = "Error creating comment. #{@comment.errors.full_messages.to_sentence}"
      redirect_to @project, alert: "Error creating comment. #{@comment.errors.full_messages.to_sentence}"
    end
  end

  def destroy
    @comment = @project.comments.find(params[:id])
    @comment.destroy

    redirect_to @project, notice: "Comment was successfully deleted."
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
