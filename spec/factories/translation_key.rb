FactoryGirl.define do
  factory :translation_key, class: 'Multilang::TranslationKey' do
    key 'greeting'

    transient do
      with_translations true
    end

    before(:create) do |key, evaluator|
      create(:language) if Multilang::Language.all.empty?
      key.create_translations if evaluator.with_translations
    end
  end
end
