require 'rails_helper'

RSpec.describe "ダイブログ登録", type: :request do
  let!(:user) { create(:user) }
  let!(:divelog) { create(:divelog, user: user) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/thumb200_default.') }
  let(:picture) { Rack::Test::UploadedFile.new(picture_path) }


  context "ログインしているユーザーの場合" do
    before do
      get new_divelog_path
      login_for_request(user)
    end

  context "フレンドリーフォワーディング" do
    it "レスポンスが正常に表示されること" do
      expect(response).to redirect_to new_divelog_url
    end
  end

it "有効なダイブログデータで登録できること" do
    expect {
      post divelogs_path, params: { divelog: { name: "大瀬崎、湾内",
                                                description:  "すばらしいダイビングポイントです",
                                                depth: 10.0,
                                                water_temp: 20,
                                                temp: 30,
                                                weather: "晴れ",
                                                visibility: 15,
                                                reference: "http://sample.com",
                                                popularity: 5,
                                                picture: picture } }
      }.to change(divelog, :count).by(1)
      follow_redirect!
      expect(response).to render_template('divelogs/show')
    end

it "無効なダイブログデータでは登録できないこと" do
    expect {
      post divelogs_path, params: { divelog: { name: "",
                                            description:  "すばらしいダイビングポイントです",
                                            depth: 10.0,
                                            water_temp: 20,
                                            temp: 30,
                                            weather: "晴れ",
                                            visibility: 15,
                                            reference: "http://sample.com",
                                            popularity: 5,
                                            picture: picture } }
      }.not_to change(divelog, :count)
      expect(response).to render_template('divelogs/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_divelog_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end