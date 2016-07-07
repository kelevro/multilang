require 'features/spec_helper'

feature 'List of languages' do
  before do
    @english = create(:language, locale: :en, name: 'English', is_default: true)
    @russian = create(:language, locale: :ru, name: 'Russian')
    visit multilang.languages_path
  end

  scenario 'will see add language button' do
    expect(page).to have_link('Add Language', href: multilang.new_language_path)
  end

  scenario 'will see add tranlsations link' do
    expect(page).to have_link('Translations', href: multilang.translations_path)
  end


  scenario 'will see languages' do
    expect(page).to have_link(@english.name, href: multilang.translations_path(lang: @english))
    expect(page).to have_link(@russian.name, href: multilang.translations_path(lang: @russian))
  end

  scenario 'will see correct control buttons for default language' do
    expect(page).not_to have_css("a[href='#{multilang.default_language_path(@english)}']")
    expect(page).not_to have_css("a[href='#{multilang.disable_language_path(@english)}']")
    expect(page).not_to have_css("a[href='#{multilang.enable_language_path(@english)}']")
    expect(page).not_to have_link('delete', href: multilang.language_path(@english))
  end

  scenario 'will see correct control buttons for not default language' do
    expect(page).to have_css("a[href='#{multilang.default_language_path(@russian)}']")
    expect(page).to have_css("a[href='#{multilang.disable_language_path(@russian)}']")
    expect(page).not_to have_css("a[href='#{multilang.enable_language_path(@russian)}']")
    expect(page).to have_link('delete', href: multilang.language_path(@russian))
  end

  scenario 'will not see control buttons after mark language as default' do
    page.find("a[href='#{multilang.default_language_path(@russian)}']").click

    expect(page).not_to have_css("a[href='#{multilang.default_language_path(@russian)}']")
    expect(page).not_to have_css("a[href='#{multilang.disable_language_path(@russian)}']")
    expect(page).not_to have_css("a[href='#{multilang.enable_language_path(@russian)}']")
    expect(page).not_to have_link('delete', href: multilang.language_path(@russian))

    expect(page).to have_css("a[href='#{multilang.default_language_path(@english)}']")
    expect(page).to have_css("a[href='#{multilang.disable_language_path(@english)}']")
    expect(page).not_to have_css("a[href='#{multilang.enable_language_path(@english)}']")
    expect(page).to have_link('delete', href: multilang.language_path(@english))
  end

  scenario 'will delete none default language' do
    page.find("a[href='#{multilang.language_path(@russian)}']").click
    expect(page).not_to have_link(@russian.name, href: multilang.edit_language_path(@russian))
  end

  scenario 'willl disable none default language' do
    page.find("a[href='#{multilang.disable_language_path(@russian)}']").click
    expect(page).to have_css("a[href='#{multilang.enable_language_path(@russian)}']")
  end
end
