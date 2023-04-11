class NewsItem < ApplicationRecord
  belongs_to :project
  belongs_to :news_itemable, polymorphic: { limit: [:Comment, :Project] }
  belongs_to :user

  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :news_itemable_id, presence: true, numericality: { only_integer: true }
  validates :news_itemable_type, presence: true, inclusion: { in: ["Comment", "Project"] }
  validates :project_id, presence: true, numericality: { only_integer: true }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validate  :news_itemable_must_be_allowed_class

  def news_itemable_must_be_allowed_class
    unless news_itemable.is_a?(Comment) || news_itemable.is_a?(Project)
      errors.add(:news_itemable, "must be a Comment or a Project")
    end
  end

  def comment?
    self.news_itemable_type == "Comment"
  end

  def project?
    self.news_itemable_type == "Project"
  end
end
