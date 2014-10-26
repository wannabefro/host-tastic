class Response < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }
  scope :persisted, -> { where 'id IS NOT NULL' }
  belongs_to :ticket
  belongs_to :staff, class_name: 'User', foreign_key: 'staff_id'

  validates_presence_of :ticket, :body

  def created?
    if self.save
      if staff
        ticket.waiting_for_customer!
        TicketMailer::new_response_email(self).deliver
        CreateResponseHistory.new(self).call
      else
        ticket.waiting_for_staff_response!
      end
    else
      return false
    end
  end

end
