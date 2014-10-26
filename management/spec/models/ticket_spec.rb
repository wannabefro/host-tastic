require 'rails_helper'

RSpec.describe Ticket, :type => :model do
  it { should belong_to(:department) }
  it { should belong_to(:assigned_staff) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:department) }

  context 'unique reference' do
    it 'should create a unique reference on being created' do
      ticket = FactoryGirl.build(:ticket)
      expect(ticket.reference).to be_nil
      ticket.save!
      expect(ticket.reload.reference).to_not be_nil
    end
  end

  context 'history' do
    it 'should create a history after creation' do
      ticket = FactoryGirl.create(:ticket)
      expect(ticket.histories.count).to eql(1)
      expect(ticket.histories.first.notes).to eql("Ticket created at #{ticket.created_at.strftime('%b %e, %l:%M %p')}")
    end
  end
end
