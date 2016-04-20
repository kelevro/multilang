FactoryGirl.define do
  factory :language, class: 'Multilang::Language' do
    locale :en
    image { Rack::Test::UploadedFile.new(File.join(Multilang::Engine.root, 'spec', 'fixtures', 'images', 'english.png')) }
    name 'English'
    completed 100
    is_default false
    is_enable true
  end
end
