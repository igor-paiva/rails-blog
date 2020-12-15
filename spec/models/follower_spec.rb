require "rails_helper"

RSpec.describe Follower, :type => :model do
  describe '.new' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    context 'when the follower and followed are the same user' do
      subject do
        described_class.new(follower_id: user.id, followed_id: user.id)
      end

      it 'is not valid' do
        is_expected.to_not be_valid
      end
    end

    context 'when the follower and followed are different users' do
      subject do
        described_class.new(follower_id: user.id, followed_id: other_user.id)
      end

      it 'is valid' do
        is_expected.to be_valid
      end
    end
  end
end
