class CreateTaverns < ActiveRecord::Migration[8.0]
  def change
    create_table :taverns do |t|
      t.string :name, null: false
      t.string :slug

      t.references :creator, null: false, foreign_key: { to_table: :user_accounts }

      t.timestamps
    end
  end
end
