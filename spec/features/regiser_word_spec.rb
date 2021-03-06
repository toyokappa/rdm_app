require "rails_helper"

feature "単語登録" do
  before do
    user = create(:user)

    login_as user
    visit root_path
    fill_in "word[content]", with: content
    click_button I18n.t("helpers.submit.create")
  end

  context "正しい値が入力された場合" do
    given(:content) { Faker::Lorem.word }
    scenario "登録できる" do
      expect(current_path).to eq root_path
      expect(page).to have_content I18n.t("flash.registration_success")
      expect(page).to have_content content
    end
  end

  context "不正な値が入力された場合" do
    given(:content) { nil }
    scenario "登録できない" do
      expect(page).to have_content I18n.t("flash.errors_count", count: 1)
    end
  end
end
