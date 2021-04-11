require 'rails_helper'

RSpec.describe divelog, type: :model do
  let!(:divelog_yesterday) { create(:divelog, :yesterday) }
  let!(:divelog_one_week_ago) { create(:divelog, :one_week_ago) }
  let!(:divelog_one_month_ago) { create(:divelog, :one_month_ago) }
  let!(:divelog) { create(:divelog) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(divelog).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      divelog = build(:divelog, name: nil)
      divelog.valid?
      expect(divelog.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      divelog = build(:divelog, name: "あ" * 31)
      divelog.valid?
      expect(divelog.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が140文字以内であること" do
      divelog = build(:divelog, description: "あ" * 141)
      divelog.valid?
      expect(divelog.errors[:description]).to include("は140文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      divelog = build(:divelog, user_id: nil)
      divelog.valid?
      expect(divelog.errors[:user_id]).to include("を入力してください")
    end

    it "人気度が1以上でなければ無効な状態であること" do
      divelog = build(:divelog, popularity: 0)
      divelog.valid?
      expect(divelog.errors[:popularity]).to include("は1以上の値にしてください")
    end

    it "人気度が5以下でなければ無効な状態であること" do
      divelog = build(:divelog, popularity: 6)
      divelog.valid?
      expect(divelog.errors[:popularity]).to include("は5以下の値にしてください")
    end
  end
  context "並び順" do
    it "最も最近の投稿が最初の投稿になっていること" do
      expect(divelog).to eq divelog.first
    end
  end
end
