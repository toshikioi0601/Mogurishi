require 'rails_helper'

RSpec.describe "divelogs", type: :system do
  let!(:user) { create(:user) }
  let!(:divelog) { create(:divelog, user: user) }


  describe "ダイブログ登録ページ" do
    before do
      login_for_system(user)
      visit new_divelog_path
    end

    context "ページレイアウト" do
      it "「ダイブログ登録」の文字列が存在すること" do
        expect(page).to have_content 'ダイブログ登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('ダイブログ登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'ポイント名'
        expect(page).to have_content '説明'
        expect(page).to have_content '天候'
        expect(page).to have_content '気温 [°C]'
        expect(page).to have_content '水温 [°C]'
        expect(page).to have_content '水深(m)'
        expect(page).to have_content '透明度 [m]'
        expect(page).to have_content '人気度 [1~5]'
        expect(page).to have_content 'ショップURL [利用したショップ]'
      end
    end

    context "ダイブログ登録処理" do
      it "有効な情報でダイブログ登録を行うと料理登録成功のフラッシュが表示されること" do
        fill_in "ポイント名", with: "大瀬崎、湾内"
        fill_in "説明", with: "すばらしいダイビングポイントです"
        fill_in "天候", with: "晴れ"
        fill_in "気温", with: 30
        fill_in "水温", with: 20
        fill_in "水深(m)", with: 10.0
        fill_in "透明度", with: 10
        fill_in "人気度", with: 5
        fill_in "ショップURL", with: "http://sample.com"
        click_button "登録する"
        expect(page).to have_content "ダイブログが登録されました！"
      end

      it "無効な情報でダイブログ登録を行うとダイブログ登録失敗のフラッシュが表示されること" do
        fill_in "ダイブログ名", with: ""
        fill_in "説明", with: "すばらしいダイビングポイントです"
        fill_in "天候", with: "晴れ"
        fill_in "気温", with: 30
        fill_in "水温", with: 20
        fill_in "水深(m)", with: 10.0
        fill_in "透明度", with: 10
        fill_in "人気度", with: 5
        fill_in "ショップURL", with: "http://sample.com"
        click_button "登録する"
        expect(page).to have_content "ダイブログ名を入力してください"
      end
    end
  end

  describe "ダイブログ詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit divelog_path(divelog)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{divelog.name}")
      end

      it "ダイブログ情報が表示されること" do
        expect(page).to have_content divelog.name
        expect(page).to have_content divelog.description
        expect(page).to have_content divelog.weather
        expect(page).to have_content divelog.water_temp
        expect(page).to have_content divelog.reference
        expect(page).to have_content divelog.temp
        expect(page).to have_content divelog.popularity
      end
    end

  context "ダイブログの削除", js: true do
      it "削除成功のフラッシュが表示されること" do
        login_for_system(user)
        visit divelog_path(divelog)
        within find('.change-divelog') do
          click_on '削除'
        end
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ダイブログが削除されました'
      end
    end
  end

  describe "ダイブログ編集ページ" do
    before do
      login_for_system(user)
      visit divelog_path(divelog)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('ダイブログ情報の編集')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'ポイント名'
        expect(page).to have_content '説明'
        expect(page).to have_content '天候'
        expect(page).to have_content '気温'
        expect(page).to have_content '水温'
        expect(page).to have_content '水深(m)'
        expect(page).to have_content '透明度'
        expect(page).to have_content '人気度 [1~5]'
      end

    context "ダイブログの削除処理", js: true do
      it "削除成功のフラッシュが表示されること" do
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ダイブログが削除されました'
      end
    end
  end

    context "ダイブログの更新処理" do
      it "有効な更新" do
        fill_in "ポイント名", with: "大瀬崎、湾内"
        fill_in "説明", with: "すばらしいダイビングポイントです"
        fill_in "天候", with: "曇り"
        fill_in "気温", with: 28
        fill_in "水温", with: 20
        fill_in "水深(m)", with: 15.0
        fill_in "透明度", with: 10
        fill_in "人気度", with: 2
        fill_in "ショップURL", with: "http://sample.com"
        click_button "更新する"
        expect(page).to have_content "ダイブログ情報が更新されました！"
        expect(divelog.reload.name).to eq "編集：大瀬崎、湾内"
        expect(divelog.reload.description).to eq "編集：すばらしいダイビングポイントです"
        expect(divelog.reload.water_temp).to eq 20
        expect(divelog.reload.temp).to eq 28
        expect(divelog.reload.weather).to eq "曇り"
        expect(divelog.reload.reference).to eq "http://sample.com"
        expect(divelog.reload.depth).to eq 15.0
        expect(divelog.reload.visibility).to eq 10
        expect(divelog.reload.popularity).to eq 2
      end

      it "無効な更新" do
        fill_in "ポイント名", with: ""
        click_button "更新する"
        expect(page).to have_content 'ポイント名を入力してください'
        expect(divelog.reload.name).not_to eq ""
      end
    end
  end
end
