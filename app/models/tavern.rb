class Tavern < ApplicationRecord
  belongs_to :creator, class_name: 'UserAccount'

  has_many :tavern_tables
  has_many :tavern_accounts

  validates :name, presence: true
end
