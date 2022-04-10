# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :new_link, only: %i[new create]

  def new; end

  def create
    new_link.assign_attributes link_params

    if new_link.save
      redirect_to links_path, notice: 'Link was successfully created'
    else
      render_template_if_error :new
    end
  end

  protected

  def link_params
    params.require(:link).permit(:long_url)
  end

  def new_link
    @new_link ||= current_user.links.build
  end
end
