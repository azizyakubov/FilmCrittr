class AddFieldsToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :movie_id, :integer
    add_column :reviews, :user_id, :integer
    add_column :reviews, :comment, :text
    add_column :reviews, :rating, :integer
  end
end
