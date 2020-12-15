require "rails_helper"

RSpec.describe Comment, :type => :model do
  describe '.new' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    subject do
      described_class.new(
        post_id: nil,
        user_id: user.id,
        content: Faker::Lorem.paragraph
      )
    end

    context 'when the user does not follow anyone' do
      it 'is not valid' do
        post = create(:post, user: other_user)

        subject.post_id = post.id

        is_expected.to_not be_valid
      end
    end

    context 'when the user follows the other' do
      before do
        Follower.create(follower_id: user.id, followed_id: other_user.id)
      end

      it 'is valid' do
        post = create(:post, user: other_user)

        subject.post_id = post.id

        is_expected.to be_valid
      end
    end
  end
end
