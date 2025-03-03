class CreateUserAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :user_accounts do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false

      t.string :display_name, null: false

      t.string :phone_number

      t.string :status

      t.string :visibility, null: false
      t.string :saved_visibility

      t.string :biography

      t.string :confirmation_token
      t.datetime :confirmation_sent_at
      t.datetime :confirmation_at

      t.string :phone_number_confirmation_token
      t.datetime :phone_number_confirmation_sent_at
      t.datetime :phone_number_confirmation_at

      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.timestamps

      t.index :username, unique: true
      t.index :email, unique: true
    end
  end
end
