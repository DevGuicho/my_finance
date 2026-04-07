require 'rails_helper'

RSpec.describe AccountPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }
  let(:other_user) { create(:user) }

  describe 'permissions' do
    subject(:policy) { described_class.new(current_user, account) }

    context 'when the user owns the account' do
      let(:current_user) { user }

      it 'permits show, update, and destroy' do
        expect(policy.show?).to be(true)
        expect(policy.update?).to be(true)
        expect(policy.destroy?).to be(true)
      end
    end

    context 'when the user does not own the account' do
      let(:current_user) { other_user }

      it 'denies show, update, and destroy' do
        expect(policy.show?).to be(false)
        expect(policy.update?).to be(false)
        expect(policy.destroy?).to be(false)
      end
    end
  end

  describe 'Scope' do
    it "returns only the user's accounts" do
      visible_account = create(:account, user: user)
      hidden_account = create(:account, user: other_user)

      resolved_scope = described_class::Scope.new(user, Account.all).resolve

      expect(resolved_scope).to contain_exactly(account, visible_account)
      expect(resolved_scope).not_to include(hidden_account)
    end
  end
end
