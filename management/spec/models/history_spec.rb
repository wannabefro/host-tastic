require 'rails_helper'

RSpec.describe History, :type => :model do
  it { should belong_to(:ticket) }

  it { should validate_presence_of(:notes) }
  it { should validate_presence_of(:ticket) }
end
