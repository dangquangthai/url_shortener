# frozen_string_literal: true

class LinksController < ApplicationController
  before_action :new_link, only: %i[new create]
  before_action :link,     only: %i[edit update destroy]

  def index
    @links = current_user.links.sorted_by_created_at.page(params[:page])
  end

  def new; end

  def create
    new_link.assign_attributes link_params

    if new_link.save
      redirect_to links_path, notice: 'Link was successfully created'
    else
      render_template_if_error :new
    end
  end

  def edit; end

  def update
    if link.update(link_params)
      redirect_to links_path, notice: 'Link was successfully updated'
    else
      render_template_if_error :edit
    end
  end

  def destroy
    link.destroy!
    redirect_to links_path, notice: 'Link was successfully deleted'
  end

  protected

  def link_params
    params.require(:link).permit(:long_url)
  end

  def new_link
    @new_link ||= current_user.links.build
  end

  def link
    @link ||= current_user.links.find(params[:id])
  end
end
