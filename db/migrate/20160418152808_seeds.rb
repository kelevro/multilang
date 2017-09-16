class Seeds < ActiveRecord::Migration[4.2]
  def up
    languages = [
      {locale: 'de', name: 'Deutsch', image: 'german.png', is_enable: true, is_default: true},
      {locale: 'en', name: 'English', image: 'english.png', is_enable: true, is_default: false}
    ]

    languages.each do |lang|
      lang_model = Multilang::Language.new lang
      if lang[:image].present?
        File.open(File.join(Multilang::Engine.root, 'db', 'data', lang[:image])) do |f|
          lang_model.image = f
        end
      end
      lang_model.save!
    end
  end

  def down
    Multilang::Language.destroy_all
  end
end
