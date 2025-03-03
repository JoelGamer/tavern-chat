class HomepageController < ApplicationController
  before_action :set_taverns

  def index; end

  private

  def set_taverns
    @taverns = @current_user.taverns
  end
end
