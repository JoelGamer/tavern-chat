class TavernAccount < ApplicationRecord
  belongs_to :tavern
  belongs_to :account, polymorphic: true

  validate :valid_association_account

  private

  def valid_association_account
    if account_type != 'ApplicationAccount' && account_type != 'UserAccount'
      errors.add(:account_type, "must be ApplicationAccount or UserAccount")
    end
  end
end
