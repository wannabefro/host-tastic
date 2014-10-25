class TicketsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def index
    if params[:q]
      ticket = Ticket.find_by(reference: params[:q][:query])
      if ticket
        redirect_to ticket_path(ticket)
      else
        @tickets = Ticket.search(params[:q][:query])
        @query = params[:q][:query]
      end
    else
      status = get_status
      @tickets = Ticket.where(status: status)
      @query = status
    end
  end

  def show
    @ticket = Ticket.find_by(reference: params[:id])
    @response = @ticket.responses.build
  end

  def update
    @ticket = Ticket.find_by(reference: params[:id])
    if @ticket.update(ticket_params)
      redirect_to ticket_path(@ticket)
    else
      render :show
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:assigned_staff_id)
  end

  def get_status
    params[:ticket] ||= {}
    params[:ticket][:status] || 'waiting_for_staff_response'
  end
end
