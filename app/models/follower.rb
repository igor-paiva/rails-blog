class Follower < ApplicationRecord
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
