class Project < ApplicationRecord
  has_many :comments, as: :commentable
  has_many :news_items, as: :news_itemable

  VALID_STATUSES = ["pending","new", "active", "completed", "archived"]

  validates :name, presence: true, length: { minimum: 4 }
  validates :status, presence: true, inclusion: { in: VALID_STATUSES }
  validates :description, presence: true, length: { minimum: 10 }

  def create_news_item(user)
    if self.saved_change_to_status?
      ni = NewsItem.create(title: "#{self.name} project status update", body: "#{self.name} status changed to #{self.status}", news_itemable_type: "Project", news_itemable_id: id, project_id: self.id, user_id: user.id)
      if ni.persisted?
        Rails.logger.info "News item created: #{ni.inspect}"
      else
        Rails.logger.info "News item not created: #{ni.errors.full_messages}"
      end
    end
  end

end
