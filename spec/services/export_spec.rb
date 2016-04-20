require 'rails_helper'
require 'yaml'

describe Multilang::Export do
  describe '#run' do
    before do
      @lang = create(:language)
      @key = create(:translation_key, key: 'greeting')
      @key.translations.each do |translation|
        translation.update_attribute :value, 'hello world'
      end
      subject.run
    end

    it 'will create locale yml file' do
      expect(File.exist?(subject.build_path(@lang.locale))).to be_truthy
    end

    it 'will have correct yml format' do
      yaml = YAML.load_file(subject.build_path(@lang.locale))
      expect(yaml[@lang.locale][@key.key]).to eq('hello world')
    end
  end
end
