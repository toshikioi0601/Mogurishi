require "rails_helper"

RSpec.describe "ダイブログの削除", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:divelog) { create(:divelog, user: user) }

  context "ログインしていて、自分のダイブログを削除する場合" do
    it "処理が成功し、トップページにリダイレクトすること" do
      login_for_request(user)
      expect {
        delete divelog_path(divelog)
      }.to change(Divelog, :count).by(-1)
      redirect_to user_path(user)
      follow_redirect!
      expect(response).to render_template('top_pages/home')
    end
  end

  context "ログインしていて、他人のダイブログを削除する場合" do
    it "処理が失敗し、トップページへリダイレクトすること" do
      login_for_request(other_user)
      expect {
        delete divelog_path(divelog)
      }.not_to change(Divelog, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end

  context "ログインしていない場合" do
    it "ログインページへリダイレクトすること" do
      expect {
        delete divelog_path(divelog)
      }.not_to change(Divelog, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
