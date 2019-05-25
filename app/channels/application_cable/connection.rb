module ApplicationCable
  class Connection < ActionCable::Connection::Base

    # include SessionsHelper
    #
    identified_by :admin_user

    def connect
      self.admin_user = find_verified_user
    end

    private

      def find_verified_user
        # binding.pryxt
        if cookies.signed[:user_id]
          Teacher.find(cookies.signed[:user_id])
        else
          reject_unauthorized_connection
        end
      end
  end
end
