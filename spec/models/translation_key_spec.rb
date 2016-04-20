require 'rails_helper'

describe Multilang::TranslationKey, type: :model do
  it { is_expected.to have_many(:translations) }
  it { is_expected.to validate_presence_of(:key) }
  it { is_expected.to validate_uniqueness_of(:key) }

  it 'will create translations for each language' do
    lang = create(:language)
    create(:translation_key)
    expect(lang.translations.count).to eq(1)
  end
end
