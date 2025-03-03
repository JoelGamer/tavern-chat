class UserAccountFriend < ApplicationRecord
  include AASM

  belongs_to :user_account_requester, class_name: 'UserAccount'
  belongs_to :user_account_receiver, class_name: 'UserAccount'

  aasm column: :status do
    state :pending, initial: true
    state :accepted, :declined
  end
end
