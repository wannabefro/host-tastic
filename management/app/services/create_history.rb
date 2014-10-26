class CreateHistory
  def initialize(ticket)
    @ticket = ticket
  end

  def call
    changes = @ticket.changes.keys
    if changes.include?('created_at')
      @notes = "Ticket created"
    else
      @notes = case
               when changes.include?('assigned_staff_id') 
                 "Ticket assigned to #{@ticket.assigned_staff.name}"
               when changes.include?('status')
                 "Status changed to #{@ticket.status.humanize}"
               else
                 "#{@ticket.name} updated their ticket"
               end
    end
    @notes += " at #{@ticket.updated_at.strftime('%b %e, %l:%M %p')}"
    History.create(notes: @notes, ticket: @ticket)
  end
end
