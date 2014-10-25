require 'rails_helper'

RSpec.describe Department, :type => :model do
  it { should have_many(:tickets) }

  it { should validate_presence_of(:name) }
  
  context 'uniqueness' do
    before(:each) { FactoryGirl.create(:department) }

    it { should validate_uniqueness_of(:name) }
  end
end
