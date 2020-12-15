require "rails_helper"
require "support/posts_helper"

RSpec.describe Post, :type => :model do
  include PostHelper

  describe '.user_followers_posts' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    let(:some_user) { create(:user) }
    let(:some_user_follower) { create(:user) }
    let(:some_user_post) { create(:post) }

    before do
      Follower.create(follower_id: some_user.id, followed_id: some_user_follower.id)

      create_list(:post, 3, user: some_user_follower)
    end

    subject { described_class.user_followers_posts(user.id) }

    context 'when user does not follow anyone' do
      it 'return an empty list' do
        is_expected.to be_empty
      end
    end

    context 'when user follow one user' do
      before do
        Follower.create(follower_id: user.id, followed_id: other_user.id)
      end

      context 'and there is not posts' do        
        it 'return an empty list' do
          is_expected.to be_empty
        end
      end

      context 'and there one post' do
        it 'return a list containing the post' do
          post = create(:post, user: other_user)

          is_expected.to match_array(relation_to_hash_array([post]))
        end
      end

      context 'and there is more than one post' do
        it 'return a list containing all posts' do
          posts = create_list(:post, 3, user: other_user)

          is_expected.to match_array(relation_to_hash_array(posts))
        end
      end
    end

    context 'when user follows more than one user' do
      let(:another_user) { create(:user) }

      before do
        Follower.create(follower_id: user.id, followed_id: other_user.id)
        Follower.create(follower_id: user.id, followed_id: another_user.id)
      end

      context 'and there is not posts' do
        it 'return an empty list' do
          is_expected.to be_empty
        end
      end

      context 'and there is one post' do
        context 'and it is from other_user' do
          it 'return a list containing the post' do
            post = create(:post, user: other_user)

            is_expected.to match_array(relation_to_hash_array([post]))
          end
        end

        context 'and it is from another_user' do
          it 'return a list containing the post' do
            post = create(:post, user: another_user)

            is_expected.to match_array(relation_to_hash_array([post]))
          end
        end
      end

      context 'and there is more than one post' do
        it 'return a list containing all posts' do
          other_user_posts = create_list(:post, 3, user: other_user)
          another_user_posts = create_list(:post, 3, user: another_user)

          is_expected.to match_array(
            relation_to_hash_array(other_user_posts + another_user_posts)
          )
        end
      end
    end
  end
end
