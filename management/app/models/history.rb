class History < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  belongs_to :ticket

  validates_presence_of :notes, :ticket
end
