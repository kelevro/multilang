require 'features/spec_helper'

feature 'List Translations', js: true do

  describe 'translation key' do
    it 'will add successfully' do
      create(:language)

      visit multilang.translations_path

      find(:css, '.new-translation-key').click
      sleep 1
      within '#new-translation-popap' do
        find(:css, '#translation_key_key').set('hello')
        click_button('Add')
      end

      expect(page).to have_content('hello')
      expect(page).to have_selector('.status-column span', text: 'Incompleted')
    end

    it 'will dont add' do
      visit multilang.translations_path

      find(:css, '.new-translation-key').click
      sleep 1
      within '#new-translation-popap' do
        find(:css, '#translation_key_key').set('hello')
        click_button('Cancel')
      end
      expect(page).to_not have_content('hello')
    end

    it 'will delete translation key successfully' do
      key = create(:translation_key)

      visit multilang.translations_path

      within ".translation-key-#{key.id}" do
        click_link('Delete')
      end

      expect(page).to_not have_content(key.key)
    end
  end

  describe 'search translations' do
    it 'will find by translation key' do
      key  = create(:translation_key)
      key2 = create(:translation_key, key: 'goodbye')

      visit multilang.translations_path

      find(:id, 'search_key').set(key.key)
      click_button('Search')

      expect(page).to have_content(key.key)
      expect(page).to_not have_content(key2.key)
    end

    it 'will find by translation text' do
      greeting = create(:translation)
      goodbye  = create(:translation, value: 'Bye!', key: 'goodbye')

      visit multilang.translations_path

      find(:id, 'search_q').set(greeting.value)
      click_button('Search')

      expect(page).to have_content(greeting.key.key)
      expect(page).to_not have_content(goodbye.key.key)
    end

    it 'will find translation for all locales' do
      create(:language, is_default: true)
      create(:language, locale: :ru)

      greeting = create(:translation_key)

      greeting.translations.each do |translation|
        translation.update_attribute :value, "hello, #{translation.language.locale}"
      end

      visit multilang.translations_path

      greeting.translations.each do |translation|
        expect(page).to have_content("hello, #{translation.language.locale}")
      end
    end

    it 'will find translations for not default language' do
      create(:language, is_default: true)
      ru = create(:language, locale: :ru, name: 'Russian')

      greeting = create(:translation_key)

      greeting.translations.each do |translation|
        translation.update_attribute :value, "hello, #{translation.language.locale}"
      end

      visit multilang.translations_path

      find(:id, 'search_lang').select(ru.name)
      click_button('Search')

      greeting.translations.each do |translation|
        expect(page).to have_content("hello, #{translation.language.locale}")
      end
    end

    it 'will find translations for not default language' do
      en = create(:language, is_default: true)
      ru = create(:language, locale: :ru, name: 'Russian')

      greeting = create(:translation_key)

      greeting.translations.each do |translation|
        translation.update_attribute :value, "hello, #{translation.language.locale}"
      end

      visit multilang.translations_path

      find(:id, 'search_lang').select(en.name)
      click_button('Search')

      expect(page).to have_content("hello, #{en.locale}")
      expect(page).to_not have_content("hello, #{ru.locale}")
    end

    it 'will find completed translations' do
      greeting = create(:translation, is_completed: true)
      goodbye  = create(:translation, value: 'Bye!', key: 'goodbye')

      visit multilang.translations_path

      find(:id, 'search_complete').select('Completed')
      click_button('Search')

      expect(page).to have_content(greeting.key.key)
      expect(page).to_not have_content(goodbye.key.key)
    end

    it 'will find incompleted translations' do
      greeting = create(:translation, is_completed: true)
      goodbye  = create(:translation, value: 'Bye!', key: 'goodbye')

      visit multilang.translations_path

      find(:id, 'search_complete').select('Incompleted')
      click_button('Search')

      expect(page).to_not have_content(greeting.key.key)
      expect(page).to have_content(goodbye.key.key)
    end
  end

  describe 'translations' do
    describe 'update text' do
      it 'will update translation value' do
        key = create(:translation_key)

        visit multilang.translations_path

        within ".translation-key-#{key.id}" do
          find(:css, '.edit-block textarea').set('Hello, World!')
          click_button('Save')
        end

        visit multilang.translations_path

        expect(page).to have_content('Hello, World!')
        expect(page).to have_selector('.status-column span', text: 'Completed')
      end
    end

    describe 'change status' do

      it 'will update translation value' do
        key = create(:translation_key)

        visit multilang.translations_path

        within ".translation-key-#{key.id}" do
          find(:css, '.edit-block textarea').set('Hello, World!')
          click_button('Save')
        end

        visit multilang.translations_path

        expect(page).to have_content('Hello, World!')
        expect(page).to have_selector('.status-column span', text: 'Completed')
      end

      it 'will mark as completed' do
        key = create(:translation_key)

        visit multilang.translations_path

        within ".translation-key-#{key.id}" do
          find(:css, '.state_change').trigger('click')
        end

        expect(page).to have_selector('.status-column span', text: 'Completed')
      end
    end
    describe 'update single value' do
      it 'will update translation value' do
        key = create(:translation_key)

        visit multilang.translations_path

        within ".translation-key-#{key.id}" do
          find(:css, '.edit-block textarea').set('Hello, World!')
          click_button('Save')
        end

        visit multilang.translations_path

        expect(page).to have_content('Hello, World!')
        expect(page).to have_selector('.status-column span', text: 'Completed')
      end

      it 'will mark as completed' do
        key = create(:translation_key)

        visit multilang.translations_path

        within ".translation-key-#{key.id}" do
          find(:css, '.state_change').trigger('click')
        end

        expect(page).to have_selector('.status-column span', text: 'Completed')
      end
    end

    describe 'update multiple values' do
      it 'will update multiple values' do
        greeting = create(:translation_key)
        goodbye  = create(:translation_key, key: 'goodbay')

        visit multilang.translations_path

        within ".translation-key-#{greeting.id}" do
          find(:css, '.edit-block textarea').set('Hello, World!')
        end

        within ".translation-key-#{goodbye.id}" do
          find(:css, '.edit-block textarea').set('Bye!')
        end

        find(:css, '.save-all-translations').click

        visit multilang.translations_path

        expect(page).to have_content('Hello, World!')
        expect(page).to have_content('Bye!')

        expect(page).to have_selector(".translation-key-#{greeting.id} .status-column span", text: 'Completed')
        expect(page).to have_selector(".translation-key-#{goodbye.id} .status-column span", text: 'Completed')
      end
    end
  end
end
