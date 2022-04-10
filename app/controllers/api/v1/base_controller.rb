# frozen_string_literal: true

module API
  module V1
    class BaseController < ActionController::Base
      include HasRescue
      include RequiredAPIKey
    end
  end
end
