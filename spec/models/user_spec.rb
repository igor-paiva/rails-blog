require "rails_helper"
require "support/users_helper"

RSpec.describe User, :type => :model do
  include UserHelper

  describe '#follower_users' do
    let(:some_user) { create(:user) }
    let(:some_user_follower) { create(:user) }

    before do
      Follower.create(follower_id: some_user_follower.id, followed_id: some_user.id)
    end

    subject { user.follower_users }

    context 'when user is not followed by anyone' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }

      it 'return an empty list' do
        is_expected.to be_empty
      end
    end

    context 'when user is followed by only one user' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }

      before do
        Follower.create(follower_id: other_user.id, followed_id: user.id)
      end

      it 'return a list containing the follower info' do
        is_expected.to match_array(relation_to_hash_array([other_user]))
      end
    end

    context 'when user is followed by more than one users' do
      let(:user) { create(:user) }
      let(:followers) { create_list(:user, 3) }

      before do
        Follower.create(follower_id: followers.first.id, followed_id: user.id)
        Follower.create(follower_id: followers.second.id, followed_id: user.id)
        Follower.create(follower_id: followers.third.id, followed_id: user.id)
      end

      it 'return a list containing all followers info' do
        is_expected.to match_array(
          relation_to_hash_array(followers)
        )
      end
    end
  end

  describe '#followed_users' do
    let(:some_user) { create(:user) }
    let(:some_user_follower) { create(:user) }

    before do
      Follower.create(follower_id: some_user.id, followed_id: some_user_follower.id)
    end

    subject { user.followed_users }

    context 'when user do not follow anyone' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }

      it 'return an empty list' do
        is_expected.to be_empty
      end
    end

    context 'when user follows only one user' do
      let(:user) { create(:user) }
      let(:other_user) { create(:user) }

      before do
        Follower.create(follower_id: user.id, followed_id: other_user.id)
      end

      it 'return a list containing the followed user' do
        is_expected.to match_array(([other_user]))
      end
    end

    context 'when user follows more than one users' do
      let(:user) { create(:user) }
      let(:followeds) { create_list(:user, 3) }

      before do
        Follower.create(follower_id: user.id, followed_id: followeds.first.id)
        Follower.create(follower_id: user.id, followed_id: followeds.second.id)
        Follower.create(follower_id: user.id, followed_id: followeds.third.id)
      end

      it 'return a list containing all followed users' do
        is_expected.to match_array(followeds)
      end
    end
  end
end
