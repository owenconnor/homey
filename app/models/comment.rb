class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :news_items, as: :news_itemable

  after_create :create_news_item

  validates :body, presence: true, length: { minimum: 10 }
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :commentable_id, presence: true, numericality: { only_integer: true }
  validates :commentable_type, presence: true, inclusion: { in: ["Project"] }

  def create_news_item
    NewsItem.create(title: "New comment on #{self.commentable_type} #{self.commentable_id}", body: self.body, news_itemable_type: "Comment", news_itemable_id: id, project_id: self.commentable_id, user_id: self.user_id)
  end
end
