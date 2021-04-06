require "rails_helper"

RSpec.describe "ダイブログ編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let(:picture2_path) { File.join(Rails.root, 'spec/fixtures/thumb400_default.png') }
  let(:picture2) { Rack::Test::UploadedFile.new(picture2_path) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(+フレンドリーフォワーディング)" do
      get edit_divelog_path(divelog)
      login_for_request(user)
      expect(response).to redirect_to edit_divelog_url(divelog)
      patch divelog_path(divelog), params: { divelog: { name: "大瀬崎、湾内",
                                                description:  "すばらしいダイビングポイントです",
                                                depth: 10.0,
                                                water_temp: 20,
                                                temp: 30,
                                                weather: "晴れ",
                                                visibility: 15,
                                                reference: "http://sample.com",
                                                popularity: 5,
                                                picture: picture2 } }
      redirect_to divelog
      follow_redirect!
      expect(response).to render_template('divelogs/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      # 編集
      get edit_divelog_path(divelog)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      # 更新
      patch divelog_path(divelog), params: { divelog: { name: "大瀬崎、湾内",
                                                description:  "すばらしいダイビングポイントです",
                                                depth: 10.0,
                                                water_temp: 20,
                                                temp: 30,
                                                weather: "晴れ",
                                                visibility: 15,
                                                reference: "http://sample.com",
                                                popularity: 5, } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      # 編集
      login_for_request(other_user)
      get edit_divelog_path(divelog)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      # 更新
      patch divelog_path(divelog), params: { divelog: { name: "大瀬崎、湾内",
                                                description:  "すばらしいダイビングポイントです",
                                                depth: 10.0,
                                                water_temp: 20,
                                                temp: 30,
                                                weather: "晴れ",
                                                visibility: 15,
                                                reference: "http://sample.com",
                                                popularity: 5, } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
