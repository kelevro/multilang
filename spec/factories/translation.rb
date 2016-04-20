FactoryGirl.define do
  factory :translation, class: 'Multilang::Translation' do
    language factory: :language
    key factory: :translation_key
    value 'Hello, World'
    is_completed false
  end
end
