require 'rails_helper'

RSpec.describe Response, :type => :model do
  it { should belong_to(:ticket) }
  it { should belong_to(:staff) }

  it { should validate_presence_of(:ticket) }
  it { should validate_presence_of(:body) }
end
