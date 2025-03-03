class CreateUserAccountFriends < ActiveRecord::Migration[8.0]
  def change
    create_table :user_account_friends do |t|
      t.string :status, null: false

      t.references :user_account_requester, null: false, foreign_key: { to_table: :user_accounts }
      t.references :user_account_receiver, null: false, foreign_key: { to_table: :user_accounts }

      t.timestamps
    end
  end
end
