class Ticket < ActiveRecord::Base
  belongs_to :department
  belongs_to :assigned_staff, class_name: 'User', foreign_key: 'assigned_staff_id'
  has_many :histories
  has_many :responses

  before_validation :generate_reference, on: :create
  after_save :update_history

  ACTIONABLE_STATES = {on_hold: 'Hold', cancelled: 'Cancel', completed: 'Complete'}

  enum status: { waiting_for_staff_response: 0, waiting_for_customer: 1, on_hold: 2, 
                 cancelled: 3, completed: 4 }

  validates_presence_of :name,
    :email,
    :body,
    :reference,
    :status,
    :department

  def to_param
    reference
  end

  def changable_states
    ACTIONABLE_STATES.select{|k, v| k != self.status.to_sym}
  end

  class << self
    def search(query)
      where('subject ILIKE ?', "%#{query}%")
    end
  end

  private

  def update_history
    CreateHistory.new(self).call
  end

  def generate_reference
    hex_numbers = SecureRandom.hex(3).upcase.scan(/../)
    char_strings = (0..8).map{ (65 + rand(26)).chr }.join.scan(/.../)
    self.reference = char_strings.zip(hex_numbers).flatten.join('-')
  end

end
