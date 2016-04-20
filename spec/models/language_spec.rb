require 'rails_helper'

describe Multilang::Language, type: :model do
  it { expect(build :language).to be_valid }

  it { is_expected.to have_many :translations }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:locale) }
  it { is_expected.to validate_length_of(:locale).is_at_most(2) }

  it { is_expected.to validate_presence_of(:image).on(:create) }

  describe '#locale uniqueness' do
    subject { build :language }
    it { is_expected.to validate_uniqueness_of(:locale).case_insensitive }
  end

  describe '.sort scope' do
    it 'will return correct order' do
      lang1  = create(:language, locale: :de, is_default: false)
      lang2  = create(:language, locale: :en, is_default: true)
      result = described_class.sort
      expect(result.first).to eq(lang2)
      expect(result.last).to eq(lang1)
    end
  end

  describe '.enable scope' do
    it 'will return one language' do
      create(:language, locale: :de, is_enable: true)
      expect(described_class.enable.count).to eq(1)
    end

    it 'will return nothing' do
      create(:language, locale: :de, is_enable: false)
      expect(described_class.enable.count).to eq(0)
    end
  end

  describe '.default scope' do
    it 'will return one language' do
      create(:language, locale: :de, is_default: true)
      expect(described_class.default.count).to eq(1)
    end
    it 'will return nothing' do
      create(:language, locale: :de, is_default: false)
      expect(described_class.default.count).to eq(0)
    end
  end

  describe '.set_default' do
    it 'will mark as default' do
      lang = create(:language, is_default: false)
      described_class.set_default(lang.id)
      expect(lang.reload.is_default).to be_truthy
    end

    it 'will mark other languages as undefault' do
      lang1 = create(:language, locale: :en, is_default: false)
      lang2 = create(:language, locale: :de, is_default: true)
      described_class.set_default(lang1.id)
      expect(lang2.reload.is_default).to be_falsy
    end
  end

  describe '.find_by_locale' do
    it 'will find language by locale' do
      language = create(:language, locale: :de)
      expect(described_class.find_by_locale(:de)).to eq(language)
    end

    it 'will return defalut language if not find by locale' do
      language = create(:language, locale: :en, is_default: true)
      expect(described_class.find_by_locale(:de)).to eq(language)
    end
  end

end
