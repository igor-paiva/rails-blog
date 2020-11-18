class Follower < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id
  belongs_to :followed, class_name: 'User', foreign_key: :followed_id

  validate :valid_users?, on: :create

  def self.follower_of?(follower_id, followed_id)
    Follower.exists?(follower_id: follower_id, followed_id: followed_id)
  end

  private

    def valid_users?
      if follower_id == followed_id
        errors.add(:same_users, 'User cannot follow himself')
      end
    end
end
