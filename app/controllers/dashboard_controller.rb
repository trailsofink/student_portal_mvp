class DashboardController < ApplicationController
  skip_before_action :require_authentication
  before_action :redirect_if_unauthenticated

  def index
    @surveys = Survey.all
  end

  private

  def redirect_if_unauthenticated
    redirect_to landing_path unless authenticated?
  end
end
