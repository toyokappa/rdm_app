require "rails_helper"

feature "単語登録" do
  before do
    log_in_as user
    click_link I18n.t("link.register_word")
    fill_in Word.human_attribute_name(:content), with: word.content
    click_button I18n.t("helpers.submit.create")
  end

  context "正しい値が入力された場合" do
    given(:user) { create :user }
    given(:word) { build :word }
    scenario "単語登録に成功する" do
      expect(page).to have_content I18n.t("flash.registration_success")
      expect(page).to have_content word.content
    end
  end

  context "不正な値が入力された場合" do
    given(:user) { create :user }
    given(:word) { build :word, content: " " }
    scenario "単語登録に失敗する" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
