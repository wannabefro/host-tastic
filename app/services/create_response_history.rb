class CreateResponseHistory
  def initialize(response)
    @response = response
  end

  def call
    @notes = "#{@response.staff.name} replied"
    @notes += " at #{@response.updated_at.strftime('%b %e, %l:%M %p')}"
    History.create(notes: @notes, ticket: @response.ticket)
  end
end
