# frozen_string_literal: true

# API module required an "api_key" parameter on each request header

module API
  module V1
    module RequiredAPIKey
      extend ActiveSupport::Concern

      included do
        before_action :required_current_user!

        protected

        def required_current_user!
          raise HasRescue::Unauthorized if current_user.blank?
        end

        def current_user
          @current_user ||= User.find_by(api_key: request_api_key)
        end

        def request_api_key
          request.headers['HTTP_API_KEY']
        end
      end
    end
  end
end
