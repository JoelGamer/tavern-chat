class TavernTableMessage < ApplicationRecord
  has_many_attached :files

  belongs_to :tavern_table

  belongs_to :account, polymorphic: true
end
