require "rails_helper"
require "support/users_helper"

RSpec.describe User, :type => :model do
  include UserHelper

  describe '.new' do
    subject do 
      described_class.new(
        name: nil,
        email: nil,
        password: 'password',
        password_confirmation: 'password'
      )
    end

    context 'when name is invalid' do
      context 'and email is invalid' do
        it 'is invalid' do
          subject.email = 'email.com'
          subject.name = Faker::Internet.username(specifier: 1..3)

          is_expected.to_not be_valid
        end
      end

      context 'and email is valid' do
        it 'is invalid' do
          subject.email = Faker::Internet.email
          subject.name = Faker::Internet.username(specifier: 15..30)

          is_expected.to_not be_valid
        end
      end
    end

    context 'when name is valid' do
      context 'and email is invalid' do
        it 'is valid' do
          subject.email = 'email.com'
          subject.name = Faker::Internet.username(specifier: 4..15)

          is_expected.to_not be_valid
        end
      end

      context 'and email is valid' do
        it 'is invalid' do
          subject.email = Faker::Internet.email
          subject.name = Faker::Internet.username(specifier: 4..15)

          is_expected.to be_valid
        end
      end
    end
  end

  describe '#follower_users' do
    let(:some_user) { create(:user) }
    let(:some_user_follower) { create(:follower_user) }

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
      let(:other_user) { create(:follower_user) }

      before do
        Follower.create(follower_id: other_user.id, followed_id: user.id)
      end

      it 'return a list containing the follower info' do
        is_expected.to match_array(relation_to_hash_array([other_user]))
      end
    end

    context 'when user is followed by more than one users' do
      let(:user) { create(:user) }
      let(:followers) { create_list(:follower_user, 3) }

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
    let(:some_user_followed) { create(:followed_user) }

    before do
      Follower.create(follower_id: some_user.id, followed_id: some_user_followed.id)
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
      let(:other_user) { create(:followed_user) }

      before do
        Follower.create(follower_id: user.id, followed_id: other_user.id)
      end

      it 'return a list containing the followed user' do
        is_expected.to match_array(([other_user]))
      end
    end

    context 'when user follows more than one users' do
      let(:user) { create(:user) }
      let(:followeds) { create_list(:followed_user, 3) }

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
