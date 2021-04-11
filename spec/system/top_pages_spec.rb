require 'rails_helper'

RSpec.describe "TopPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "潜師の文字列が存在することを確認" do
        expect(page).to have_content '潜師'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end

      context "ダイブログのフィード", js: true do
        let!(:user) { create(:user) }
        let!(:divelog) { create(:divelog, user: user) }

        before do
          login_for_system(user)
        end

        it "ダイブログのぺージネーションが表示されること" do
          login_for_system(user)
          create_list(:divelog, 6, user: user)
          visit root_path
          expect(page).to have_content "みんなのダイブログ (#{user.divelogs.count})"
          expect(page).to have_css "div.pagination"
          divelog.take(5).each do |d|
            expect(page).to have_link d.name
          end
        end

        it "「新しいダイブログを作る」リンクが表示されること" do
         visit root_path
         expect(page).to have_link "新しいダイブログを作る", href: new_dish_path
       end
       
       it "ダイブログを削除後、削除成功のフラッシュが表示されること" do
        visit root_path
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ダイブログが削除されました'
      end
    end
  end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it "潜師とは？の文字列が存在することを確認" do
      expect(page).to have_content '潜師とは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('潜師とは？')
    end
  end

  describe "利用規約ページ" do
    before do
      visit use_of_terms_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('利用規約')
    end
  end
end
