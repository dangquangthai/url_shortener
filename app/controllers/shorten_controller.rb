# frozen_string_literal: true

class ShortenController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    link = Link.find_by!(token: params[:token])
    link.clicked_count_increasing!

    redirect_to link.long_url
  end
end
