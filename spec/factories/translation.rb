FactoryGirl.define do
  factory :translation, class: 'Multilang::Translation' do
    value 'Hello, World'
    is_completed false

    transient do
      key 'greeting'
      language { Multilang::Language.first || create(:language) }
    end

    before(:create) do |translation, evaluator|
      if evaluator.key.is_a? String
        translation.key = create(:translation_key,
                                 key:               evaluator.key,
                                 with_translations: false)
      else
        translation.key = key
      end

      translation.language = evaluator.language
    end
  end
end
