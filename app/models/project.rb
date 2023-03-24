class Project < ApplicationRecord
  has_many :comments, as: :commentable


end
