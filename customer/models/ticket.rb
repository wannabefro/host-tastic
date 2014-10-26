require 'httparty'

class Ticket
  include HTTParty

  def initialize(options)
    @options = options
  end

  def submit
    return false if any_blank_values
    submission = self.class.post(ENV['SUPPORT_URL'], body: {ticket: @options},
                    headers: {"Authorization" => "Token token=\"#{ENV['API_TICKET_KEY']}\""})
    submission.code == 200
  end

  private

  def any_blank_values
    @options.each do |k, v|
      return true if v.empty?
    end
    false
  end
end
