require 'rails_helper'

describe Multilang::Translation, type: :model do
  it { expect(build(:translation)).to be_valid }
  it { is_expected.to belong_to(:language) }
  it { is_expected.to belong_to(:key) }

  it 'will change language complation' do
    create(:language, completed: 0)
    translation = create(:translation_key).translations.first
    expect { translation.change_status }
      .to change { translation.language.completed }.from(0).to(100)
  end

  describe '.langs' do
    before do
      @default_lang = create(:language, locale: :en, is_default: true)
      @de_lang      = create(:language, locale: :de)
      create(:language, locale: :ru)
      create(:translation_key)
    end

    it 'will find all translations' do
      expect(described_class.langs(default: 'all').count)
        .to eq(described_class.count)
    end

    it 'will find only default translation' do
      expect(described_class.langs(default: @default_lang).count).to eq(1)
    end

    it 'will find translation for language with default' do
      expect(described_class.langs(default: @default_lang, lang: @de_lang).count)
        .to eq(2)
    end
  end

  describe '#change_status' do
    it 'will mark as uncompleted' do
      translation = create(:translation, is_completed: true)
      expect { translation.change_status }
        .to change { translation.is_completed }.from(true).to(false)
    end

    it 'will mark as completed' do
      translation = create(:translation, is_completed: false)
      expect { translation.change_status }
        .to change { translation.is_completed }.from(false).to(true)
    end
  end

end
