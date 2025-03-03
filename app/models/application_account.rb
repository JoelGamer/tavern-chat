class ApplicationAccount < ApplicationRecord
  include AASM

  has_secure_password :token

  has_one_attached :avatar

  aasm column: :visibility do
    state :available, initial: true
    state :away, :busy, :offline
  end

  def display_name_abbreviation
    splitted = display_name.split(' ')
    splitted.length >= 2 ? "#{splitted.first.first}#{splitted.last.first}" : "#{display_name[0]}#{display_name[1]}"
  end
end
