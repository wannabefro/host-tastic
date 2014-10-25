class TicketMailer < ActionMailer::Base
  default from: 'support@ticketing.com'

  def new_ticket_email(ticket)
    @ticket = ticket
    mail(to: @ticket.email, subject: "New ticket #{@ticket.reference}")
  end
end
