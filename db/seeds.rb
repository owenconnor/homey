pp "Seeding database..."
pp "Creating users..."
comment_user = User.create!(
  email: "comment_user@example.com",
  password: "password",
  password_confirmation: "password"
)
pp "======== comment_user: #{comment_user.inspect}========"
test_user = User.create!(
  email: "test_user@example.com",
  password: "password",
  password_confirmation: "password"
)
pp "======== test_user: #{test_user.inspect}========"

pp "Creating projects..."
project = Project.create(
  name: "Homey Converstation",
  description: "Project timeline to record project decisions",
  status: "active"
)
pp "======== project: #{project.inspect}========"
conversation = [
  {question:"What is a Project? What does is represent? How should it be modeled?", answer:"It's and obejct which holds details of a project which people can comment on"},
  {question:"What are the possible statuses of a project?", answer:"pending, new, active, completed, archived"},
  {question:"How does the status or changing it alter the representation of the project?", answer:"Just the status will be altered for now, it won't alter the overall display fo the project"},
  {question:"Is there a workflow to the status changes with a specific order the statuses should be changed in?", answer:"No. For now projects can be changed to any status in any order"},
  {question:"The list of items includes comments and updates to the project status, can anything else appear there?", answer:"No, in the future other elements like tasks or other project related objects could be added."},
  {question:"Can users reply to comments? Should replies be nested?", answer:"To start users can comment on the project and not reply to comments. In the future replies could be nested if that adds value"},
  {question:"What types of data can the comment object include? Pictures/videos attachments etc", answer:"At the moment just text, in the future attachments/images could be added"},
  {question:"Can a user comment only on the project or on any items that appear in the list eg status updates?", answer:"Just the project for now, in the future other items could be commented on"},
  {question:"Who can create a project anyone?", answer:"Any user can create a project"},
  {question:"Does a project have an owner?", answer:"no at the moment, but in the future a project could have an owner"},
  {question:"Who can change a project status?", answer:"any user can change the status"},
  {question:"Are any users priveledges available at any stage?", answer:"no, for now anyone can create a project and comment on it"},
  {question:"Does a user have to be associated to a project to comment?", answer:"no, for now anyone can comment on a project"},
  {question:"What changes are possible in the future", answer:"Potentially nested comments, attachments/images, tasks, other project related objects"},
]
pp  "creating comments..."

conversation.each do |item|
  item.each do |k,v|
    # Rails.logger.info " ==== Creating comment: #{k} - #{v} / user:#{user.id} / project: #{project.id}"
    comment = project.comments.create(
      user_id: comment_user.id,
      commentable_type: "Project",
      body: v,
    )
    if comment.persisted?
      Rails.logger.info " ==== Comment created: #{comment.inspect}"
    else
      Rails.logger.info " ==== Comment not created: #{comment.errors.full_messages}"
    end
  end

end

