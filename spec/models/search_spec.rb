require 'rails_helper'

describe Multilang::Search, type: :model do

  it 'will correct initialize' do
    expect(subject.lang).to eq('all')
    expect(subject.complete).to eq('all')
  end

  describe '#languages_list' do
    it 'will contain correct keys' do
      lang = create(:language)
      expect(subject.languages_list.to_h.keys)
        .to contain_exactly('All locales', lang.name)
    end
  end

  describe '#language' do
    it 'will return all' do
      expect(subject.language).to eq({ default: 'all' })
    end

    it 'will return default language' do
      lang   = create(:language, is_default: true)
      search = Multilang::Search.new(lang: lang.id)
      expect(search.language).to eq({ default: lang })
    end

    it 'will return language with default' do
      lang    = create(:language, is_default: true)
      ru_lang = create(:language, locale: :ru)
      search  = Multilang::Search.new(lang: ru_lang.id)
      expect(search.language).to eq({ default: lang, lang: ru_lang })
    end
  end
end