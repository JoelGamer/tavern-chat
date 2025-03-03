class TavernTable < ApplicationRecord
  enum :variant, { text: 0, voice: 1 }
  belongs_to :tavern

  has_many :tavern_table_messages

  validates :name, presence: true
end
