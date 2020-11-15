class Comment < ApplicationRecord
  belongs_to :post

  validate :valid_user?, on: :create
  validates :content, presence: true

  def valid_user?
    post = Post.find(post_id)

    unless Follower.follower_of?(user_id, post.user_id)
      errors.add(:not_follower, 'User is not a follower of post owner')
    end
  end
end
