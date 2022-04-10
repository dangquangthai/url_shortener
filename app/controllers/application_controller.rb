# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  include HasRescue

  protected

  def render_template_if_error(template)
    flash.now[:error] = 'Something went wrong, please review below errors'
    render template, status: :unprocessable_entity
  end
end
