class CreateTavernTables < ActiveRecord::Migration[8.0]
  def change
    create_table :tavern_tables do |t|
      t.integer :variant, null: false, default: 0
      t.string :name, null: false
      t.boolean :explicit_content, null: false, default: false

      t.references :tavern, null: false, foreign_key: true

      t.timestamps
    end
  end
end
