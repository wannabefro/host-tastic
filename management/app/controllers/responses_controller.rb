class ResponsesController < ApplicationController
  def create
    @ticket = Ticket.find_by(reference: params[:ticket_id])
    @response = @ticket.responses.build(response_params)
    @response.staff = current_user if current_user
    if @response.created?
      redirect_to ticket_path(@ticket)
    else
      redirect_to ticket_path(@ticket), alert: 'Sorry something went wrong. Please try again'
    end
  end

  private

  def response_params
    params.require(:response).permit(:body, :ticket_id, :staff_id)
  end
end
