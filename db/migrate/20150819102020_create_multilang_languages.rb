class CreateMultilangLanguages < ActiveRecord::Migration[4.2]
  def change
    create_table :multilang_languages do |t|
      t.string :locale, null: false
      t.string :image
      t.string :name
      t.integer :completed, null: false, default: 0
      t.boolean :is_default, null: false, default: false
      t.boolean :is_enable, null: false, default: true

      t.timestamps null: false
    end
  end
end
