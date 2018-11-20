class Review < ApplicationRecord
  # belongs_to :user
  # belongs_to :movie
  validates_presence_of :title, :user_email, :rating, :created_at
end
