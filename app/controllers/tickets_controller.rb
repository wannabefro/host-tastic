class TicketsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    status = get_status
    @tickets = Ticket.where(status: status)
    @ticket_type = status
  end

  private

  def get_status
    params[:ticket] ||= {}
    params[:ticket][:status] || 'waiting_for_staff_response'
  end
end
