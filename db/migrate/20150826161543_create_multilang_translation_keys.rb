class CreateMultilangTranslationKeys < ActiveRecord::Migration
  def change
    create_table :multilang_translation_keys do |t|
      t.string :key

      t.timestamps
    end

    add_index :multilang_translation_keys, :key
  end
end
