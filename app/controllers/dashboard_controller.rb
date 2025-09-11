class DashboardController < ApplicationController
  skip_before_action :require_authentication
  before_action :redirect_if_unauthenticated

  def index
    new_survey = Survey.new
    new_survey.program = "PROG-0143"
    new_survey.save
    @surveys = Survey.all
  end

  private

  def redirect_if_unauthenticated
    redirect_to landing_path unless authenticated?
  end
end
