class TavernsController < ApplicationController
  before_action :set_taverns
  before_action :set_tavern, only: %i[show]

  def show; end

  private

  def set_tavern
    @tavern = @taverns.find(params[:id])
  end

  def set_taverns
    @taverns = @current_user.taverns
  end
end
