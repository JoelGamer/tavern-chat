class CreateApplicationAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :application_accounts do |t|
      t.string :username, null: false
      t.string :token_digest, null: false

      t.string :display_name, null: false

      t.string :status

      t.string :visibility, null: false
      t.string :saved_visibility

      t.string :biography

      t.string :confirmation_token
      t.datetime :confirmation_sent_at

      t.timestamps

      t.index :username, unique: true
    end
  end
end
