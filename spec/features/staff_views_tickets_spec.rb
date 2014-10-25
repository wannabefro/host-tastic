require 'rails_helper'

feature 'staff member views tickets' do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:unassigned_ticket) { FactoryGirl.create(:ticket, :waiting_for_staff_response) }
  let!(:open_ticket) { FactoryGirl.create(:ticket, :waiting_for_customer) }
  let!(:on_hold_ticket) { FactoryGirl.create(:ticket, :on_hold) }
  let!(:closed_ticket) { FactoryGirl.create(:ticket, :completed) }

  scenario 'tickets page should default to unassigned tickets' do
    signin(user)
    visit tickets_path
    expect(page).to have_content('Waiting for staff response')
    expect(page).to have_content(unassigned_ticket.subject)
    expect(page).to_not have_content(open_ticket.subject)
  end

  scenario 'a user can filter tickets by state' do
    signin(user)
    visit tickets_path
    expect(page).to_not have_content(open_ticket.subject)
    select 'Waiting for customer', from: 'Ticket Status'
    click_on 'Update'
    expect(page).to have_content(open_ticket.subject)
  end

  scenario 'a user must be signed in to visit the page' do
    visit tickets_path
    expect(current_path).to eql(new_user_session_path)
  end
end
