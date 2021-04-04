module ApplicationHelper
  def full_title(page_title = '') # full_titleメソッドを定義
    base_title = '潜師'
    if page_title.blank?
      base_title # トップページはタイトル「潜師」
    else
      "#{page_title} - #{base_title}" # トップ以外のページはタイトル「利用規約 - 潜師」
    end
  end
end
