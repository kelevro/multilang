require 'rails_helper'

describe Multilang::Searcher do

  describe '#translation_keys' do
    before do
      create(:language, is_default: true)
      @translation_key = create(:translation_key)
      @translation_key.translations.first.update_attribute(:value, 'Hello, World')
      create(:translation_key, key: 'world')
    end

    it 'will find by key' do
      searcher = build_searcher(key: 'hello')
      expect(searcher.translation_keys.count).to eq(1)
    end

    it 'will find by translation value' do
      searcher = build_searcher(q: 'hello')
      expect(searcher.translation_keys.count).to eq(1)
    end

    it 'will not find by completed translations' do
      searcher = build_searcher(complete: true)
      expect(searcher.translation_keys.count).to eq(0)
    end

    it 'will find by completed translations' do
      searcher = build_searcher(complete: false)
      expect(searcher.translation_keys.count).to eq(2)
    end
  end

  def build_searcher(attrs = {})
    Multilang::Searcher.new(Multilang::Search.new(attrs))
  end
end