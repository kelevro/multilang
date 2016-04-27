require 'features/spec_helper'

feature 'New language' do
  before do
    @english = create(:language, locale: :en, name: 'English', is_default: true)
    visit multilang.new_language_path
  end

  scenario 'will have validation errors' do
    page.click_button('Create Language')
    expect(page).to have_current_path(multilang.languages_path)

    within '.language_locale' do
      expect(page).to have_content("can't be blank")
    end

    within '.language_name' do
      expect(page).to have_content("can't be blank")
    end

    within '.language_image' do
      expect(page).to have_content("can't be blank")
    end

    fill_in('Locale', with: 'en')
    page.click_button('Create Language')

    within '.language_locale' do
      expect(page).to have_content('has already been taken')
    end
  end

  scenario 'will success create language' do
    fill_in('Locale', with: 'ru')
    fill_in('Name', with: 'Russian')
    attach_file('Image', Multilang::Engine.root.join('spec', 'fixtures',
                                                     'images', 'english.png'))
    click_button('Create Language')
    expect(page).to have_current_path(multilang.languages_path)
    expect(page).to have_link('Russian')
  end
end
