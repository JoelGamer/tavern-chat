class CreateTavernTableMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :tavern_table_messages do |t|
      t.string :content

      t.references :tavern_table, null: false, foreign_key: true
      t.references :account, null: false, polymorphic: true

      t.timestamps
    end
  end
end
