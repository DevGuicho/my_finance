require 'rails_helper'

RSpec.describe "/accounts", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /index" do
    it "returns success for the sign in user" do
      get "/accounts"
      expect(response).to have_http_status(:success)
    end

    it "only shows the current user's accounts" do
      current_user_account = create(:account, user: user, name: "User Visible Account")
      other_user_account = create(:account, name: "Other User Hidden Account")

      get "/accounts"

      expect(response).to have_http_status(:success)
      expect(response.body).to include(current_user_account.name)
      expect(response.body).not_to include(other_user_account.name)
    end
  end

  describe "POST /create" do
    it "creates a new account with valid params" do
      account_params = attributes_for(:account)

      expect {
        post "/accounts", params: { account: account_params }
      }.to change(Account, :count).by(1)

      expect(response).to have_http_status(:found) # Redirect after successful creation
    end

    it "does not create an account with invalid params" do
      account_params = attributes_for(:account, name: nil)
      expect { post "/accounts", params: { account: account_params } }.to change(Account, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "UPDATE /update" do
    let(:account) { create(:account, user: user, name: "Old Account Name", kind: :cash) }

    it "updates an account with valid params" do
      account_params = { name: "Updated Account Name", kind: :savings }

      patch "/accounts/#{account.id}",
            params: { account: account_params },
            headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }

      expect(response).to have_http_status(:success)
      expect(account.reload.name).to eq("Updated Account Name")
      expect(account.kind).to eq("savings")
    end

    it "does not update an account with invalid params" do
      patch "/accounts/#{account.id}", params: { account: { name: nil } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(account.reload.name).to eq("Old Account Name")
    end

    it "does not update another user's account" do
      other_user_account = create(:account, name: "Other Account", kind: :cash)

      expect {
        patch "/accounts/#{other_user_account.id}",
              params: { account: { name: "Should Not Update" } },
              headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }
      }.to raise_error(Pundit::NotAuthorizedError)

      expect(other_user_account.reload.name).to eq("Other Account")
    end
  end


  describe "DELETE /destroy" do
    it "deletes an account owned by the signed in user" do
      account = create(:account, user: user)

      expect {
        delete "/accounts/#{account.id}", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }
      }.to change(Account, :count).by(-1)

      expect(response).to have_http_status(:success)
    end

    it "does not delete another user's account" do
      other_user_account = create(:account)

      expect {
        delete "/accounts/#{other_user_account.id}", headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }
      }.to raise_error(Pundit::NotAuthorizedError)

      expect(Account.exists?(other_user_account.id)).to be(true)
    end
  end
end
