# frozen_string_literal: true

module API
  module V1
    class LinksController < BaseController
      def index
        @links = current_user.links.sorted_by_created_at.page(params[:page])
      end

      def create
        @new_link = current_user.links.build link_params

        json_response({ errors: @new_link.errors }, :unprocessable_entity) unless @new_link.save
      end

      protected

      def link_params
        params.require(:link).permit(:long_url)
      end
    end
  end
end
