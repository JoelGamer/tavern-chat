class TavernTablesController < ApplicationController
  before_action :set_tavern
  before_action :set_tavern_table, only: %i[show]

  def show; end

  private

  def set_tavern_table
    @tavern_table = @tavern.tavern_tables.find(params[:id])
  end

  def set_tavern
    @tavern = @current_user.taverns.find(params[:tavern_id])
  end
end
