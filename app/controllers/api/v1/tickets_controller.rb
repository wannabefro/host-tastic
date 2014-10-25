class Api::V1::TicketsController < ApplicationController
  before_action :authenticate_request
  respond_to :json

  def create
    @ticket = Ticket.new(ticket_params)
    if @ticket.save
      TicketMailer::new_ticket_email(@ticket).deliver
      render json: {status: 'success'}
    else
      render json: {status: 'failed', error: @ticket.errors}
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:name, :email, :department_id, :body, :subject)
  end

  def authenticate_request
    authenticate_or_request_with_http_token do |token,other_options|
      token == ENV['API_TICKET_KEY']
    end
  end
end
