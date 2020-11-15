class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true

  scope :user_followers_posts, ->(user_id) {
    ActiveRecord::Base.connection.execute <<-SQL
      SELECT posts.* FROM posts
      INNER JOIN followers ON followers.followed_id = posts.user_id
      INNER JOIN users ON users.id = followers.follower_id
      WHERE followers.follower_id = #{user_id}
    SQL
  }
end
