require 'rails_helper'

feature 'viewing a ticket' do
  let(:user) { FactoryGirl.create(:user) }
  let(:ticket) { FactoryGirl.create(:ticket) }
  scenario 'it should show the history for the ticket' do
    visit ticket_path(ticket)
    expect(page).to have_content("Ticket created at #{ticket.created_at}")
  end

  context 'assigning ticket' do
    scenario 'only a signed in user can see staff controls' do
      visit ticket_path(ticket)
      expect(page).to_not have_content('Assign to:')
      signin(user)
      visit ticket_path(ticket)
      expect(page).to have_content('Assign to:')
    end

    scenario 'assigning a ticket' do
      signin(user)
      visit ticket_path(ticket)
      select user.name, from: 'Assign to'
      click_on 'Assign'
      expect(ticket.reload.assigned_staff).to eql(user)
      expect(page).to have_content("Ticket assigned to #{user.name}")
    end
  end

  context 'responding to a ticket' do
    let(:ticket) { FactoryGirl.create(:ticket, assigned_staff: user) }
    scenario 'staff member replies to ticket' do
      previous_email_count = ActionMailer::Base.deliveries.count
      reply_body = Faker::Lorem.paragraph
      signin(user)
      visit ticket_path(ticket)
      fill_in 'Response', with: reply_body
      click_on 'Reply'
      expect(page).to have_content(reply_body)
      expect(ticket.reload.status).to eql('waiting_for_customer')
      expect(ActionMailer::Base.deliveries.count).to eql(previous_email_count + 1)
      expect(page).to have_content ("#{user.name} replied at")
    end

    scenario 'contacter replies to own ticket' do
      previous_email_count = ActionMailer::Base.deliveries.count
      reply_body = Faker::Lorem.paragraph
      visit ticket_path(ticket)
      fill_in 'Response', with: reply_body
      click_on 'Reply'
      expect(ticket.reload.status).to eql('waiting_for_staff_response')
      expect(page).to have_content("#{ticket.name} updated their ticket")
      expect(ActionMailer::Base.deliveries.count).to eql(previous_email_count)
    end
  end
end
