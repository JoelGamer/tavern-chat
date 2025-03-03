module Accounts
  class AccountVisibilityChannel < ApplicationCable::Channel
    def subscribed
      # stream_from "some_channel"

      current_user.connect! if current_user.may_connect?
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed

      current_user.disconnect! if current_user.may_disconnect?
    end

    def visibility(data)
      current_user.active! if current_user.may_active?
    end

    def away
      current_user.idle! if current_user.may_idle?
    end
  end
end
