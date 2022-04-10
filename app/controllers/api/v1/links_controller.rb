# frozen_string_literal: true

module API
  module V1
    class LinksController < BaseController
      def index
        @links = current_user.links.sorted_by_created_at.page(params[:page])
      end
    end
  end
end
