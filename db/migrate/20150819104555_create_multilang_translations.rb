class CreateMultilangTranslations < ActiveRecord::Migration[4.2]
  def change
    create_table :multilang_translations do |t|
      t.belongs_to :multilang_language
      t.belongs_to :multilang_translation_key
      t.text :value
      t.boolean :is_completed

      t.timestamps null: false
    end

    add_index :multilang_translations, :multilang_language_id
    add_index :multilang_translations, :multilang_translation_key_id
  end
end
