class History < ActiveRecord::Base
  belongs_to :ticket

  validates_presence_of :notes, :ticket
end
