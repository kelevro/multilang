require 'rails_helper'
require 'yaml'

describe Multilang::Export do
  describe '#run' do
    before do
      @lang = create(:language)
      @key  = create(:translation_key, key: 'greeting')
      @key.translations.each do |translation|
        translation.update_attribute(:value, 'hello world')
      end
      subject.run
      @file_path = File.join(Rails.root,
                             Multilang.locale_path,
                             "#{@lang.locale}.yml")
    end

    describe 'file backend' do
      it 'will create locale yml file' do
        expect(File.exist?(@file_path)).to be_truthy
      end

      it 'will have correct yml format' do
        yaml = YAML.load_file(@file_path)
        expect(yaml[@lang.reload.locale][@key.key]).to eq('hello world')
      end
    end

    describe 'redis backend' do
      before do
        @redis = I18n.backend.store
      end

      it 'will write to redis correct data' do
        key = "#{@lang.locale}.#{@key.key}"
        expect(@redis.keys).to include(key)
        expect(@redis.get(key)).to eq('"hello world"')
      end
    end
  end
end
