# frozen_string_literal: true

module HasRescue
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError,                      with: :internal_server_error
    rescue_from ActionController::ParameterMissing, with: :bad_request
    rescue_from ActiveRecord::RecordNotFound,       with: :not_found

    protected

    def json_response(object, status = :ok)
      render json: object, status: status
    end

    def internal_server_error(execption)
      raise_execption_to_dev_team(execption)
      json_response({ error: execption.message }, :internal_server_error)
    end

    def bad_request
      json_response({ error: 'Required params is missing' }, :bad_request)
    end

    def not_found
      json_response({ error: 'Resource not found' }, :not_found)
    end

    def raise_execption_to_dev_team(execption)
      Rails.logger.error(execption.message)
      # Use 3rd as rollbar, sentry or just send an email
    end
  end
end
