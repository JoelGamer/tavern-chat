class CreateTavernAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :tavern_accounts do |t|
      t.references :tavern, null: false, foreign_key: true
      t.references :account, null: false, polymorphic: true

      t.timestamps
    end
  end
end
