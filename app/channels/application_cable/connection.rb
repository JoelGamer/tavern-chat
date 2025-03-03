module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = authenticated_user
    end

    private

    def authenticated_user
      if user_account = UserAccount.find_by(id: cookies.encrypted[:_chat_session]['current_user_id'])
        user_account
      else
        reject_unauthorized_connection
      end
    end
  end
end
