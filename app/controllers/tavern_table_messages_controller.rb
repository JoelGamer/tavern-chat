class TavernTableMessagesController < ApplicationController
  before_action :set_tavern, :set_tavern_table

  def create
    @tavern_table_message = @tavern_table.tavern_table_messages.create!(**create_params, account: @current_user)

    Turbo::StreamsChannel.broadcast_prepend_later_to(@tavern_table, :tavern_table_messages,
      target: 'tavern_table_messages',
      partial: 'tavern_table_messages/message',
      locals: { tavern_table_message: @tavern_table_message }
    )
  rescue StandardError => error
    Rails.logger.error(error)
    Rails.logger.error(error.backtrace)

    respond_to do |format|
      format.html { redirect_back fallback_location: new_session_path, error: e.message }
      format.turbo_stream { flash.now[:error] = error.message }
    end
  end

  private

  def create_params
    params.require(:tavern_table_message).permit(:content, :files)
  end

  def set_tavern_table
    @tavern_table = @tavern.tavern_tables.find(params[:table_id])
  end

  def set_tavern
    @tavern = @current_user.taverns.find(params[:tavern_id])
  end
end
