require 'rails_helper'

describe Api::V1::TicketsController do
  let(:ticket) { FactoryGirl.build(:ticket) }
  let(:valid_json) do
    {
      format: 'json',
      ticket: {
        name: ticket.name,
        email: ticket.email,
        department_name: ticket.department.name,
        body: ticket.body,
        subject: ticket.subject
      }
    }
  end
  it 'should create a new ticket if valid params' do
    previous_ticket_count = Ticket.count
    post api_v1_tickets_path, valid_json, {'HTTP_AUTHORIZATION' => credentials}
    expect(response.code).to eql('200')
    expect(Ticket.count).to eql(previous_ticket_count + 1)
  end

  it 'should send an email after being created' do
    previous_email_count = ActionMailer::Base.deliveries.count
    post api_v1_tickets_path, valid_json, {'HTTP_AUTHORIZATION' => credentials}
    expect(ActionMailer::Base.deliveries.count).to eql(previous_email_count + 1)
  end

  it 'should not create a new ticket if no api key' do
    post api_v1_tickets_path, valid_json
    expect(response.code).to eql('401')
  end

  def credentials
    ActionController::HttpAuthentication::Token.encode_credentials(ENV['API_TICKET_KEY'])
  end
end
