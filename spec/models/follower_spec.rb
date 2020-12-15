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

  describe '.follower_of?' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    
    subject { described_class.follower_of?(user.id, other_user.id) }

    context 'when the user does not follow the other' do
      it 'return false' do
        is_expected.to eq(false)
      end
    end

    context 'when the user follows the other' do
      before do
        Follower.create(follower_id: user.id, followed_id: other_user.id)
      end

      it 'return true' do
        is_expected.to eq(true)
      end
    end
  end
end
