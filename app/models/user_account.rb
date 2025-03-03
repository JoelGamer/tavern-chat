class UserAccount < ApplicationRecord
  include AASM

  has_secure_password

  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_fill: [48, 48]
  end

  has_many :tavern_accounts, as: :account
  has_many :taverns, through: :tavern_accounts

  has_many :user_account_friends, lambda { |friend| unscope(where: :user_account_id).where('user_account_requester_id = ? OR user_account_receiver_id = ?', friend.id, friend.id) }, dependent: :destroy, inverse_of: false

  validates :username, :email, :display_name, :visibility, presence: true
  validates :username, :email, uniqueness: true

  aasm column: :visibility do
    state :available, initial: true
    state :away, :busy, :offline

    event :connect, after_commit: :broadcast_visibility do
      transitions from: :offline, to: :available
    end

    event :active, after_commit: :broadcast_visibility do
      transitions from: :away, to: :available
    end

    event :idle, after_commit: :broadcast_visibility do
      transitions from: :available, to: :away
    end

    event :disconnect, after_commit: :broadcast_visibility do
      transitions from: [:available, :away, :busy], to: :offline
    end
  end

  def friends
    UserAccount.find(
      user_account_friends
        .select("CASE WHEN user_account_friends.user_account_requester_id <> #{self.id} THEN user_account_friends.user_account_requester_id WHEN user_account_friends.user_account_receiver_id <> #{self.id} THEN user_account_friends.user_account_receiver_id ELSE 0 END AS friend_id")
        .map(&:friend_id)
    )
  end

  def send_friend_request(requester: self, receiver:)
    UserAccountFriend.create!(user_account_requester: requester, user_account_receiver: receiver)
  end

  def confirmed?
    confirmation_at.present?
  end

  def phone_number_confirmed?
    phone_number_confirmation_at.present?
  end

  def broadcast_visibility
    Turbo::StreamsChannel.broadcast_replace_later_to(self, :visibility,
      target: "account-#{self.id}-visibility-indicator",
      partial: 'accounts/visibility_indicator',
      locals: { account: self }
    )

    Turbo::StreamsChannel.broadcast_replace_later_to(self, :visibility,
      target: "account-#{self.id}-visibility-text",
      partial: 'accounts/visibility_text',
      locals: { account: self }
    )
  end

  def display_name_abbreviation
    splitted = display_name.split(' ')
    splitted.length >= 2 ? "#{splitted.first.first}#{splitted.last.first}" : "#{display_name[0]}#{display_name[1]}"
  end
end
