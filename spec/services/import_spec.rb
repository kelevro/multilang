require 'rails_helper'

describe Multilang::Import do
  describe '#initialize' do
    it 'will set relative path' do
      expect(described_class.new('config/locales').path)
        .to eq(Multilang::Engine.root.join('config/locales'))
    end

    it 'will set absolute path' do
      expect(described_class.new(locales_path).path)
        .to eq(Multilang::Engine.root.join('spec/fixtures/locales'))
    end
  end

  describe '#run' do
    before do
      @lang = create(:language, locale: :en)
    end

    it 'will import by file path' do
      expect {described_class.new(locales_path(@lang.locale)).run}
        .to change {Multilang::TranslationKey.count}.from(0).to(1)
    end

    it 'will import by directory path' do
      expect {described_class.new(locales_path).run}
        .to change {Multilang::TranslationKey.count}.from(0).to(1)
    end

    it 'will import by default locales path' do
      add_locales_path_to_default(@lang.locale)
      described_class.new.run
      expect(Multilang::TranslationKey.where(key: 'greeting').count).to eq(1)
    end

    it 'will not ovirride existing translation' do
        key = create(:translation_key, key: 'greeting')
        translation = key.translations.language(@lang).first
        translation.update_attribute :value, 'Hi, World!'
        described_class.new(locales_path).run
        expect(translation.reload.value).to eq('Hi, World!')
    end

    it 'will ovirride existing translation' do
        key = create(:translation_key, key: 'greeting')
        translation = key.translations.language(@lang).first
        translation.update_attribute :value, 'Hi, World!'
        described_class.new(locales_path, true).run
        expect(translation.reload.value).to eq('Hello, World!')
    end
  end
end
