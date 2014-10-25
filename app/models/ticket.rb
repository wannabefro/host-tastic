class Ticket < ActiveRecord::Base
  belongs_to :department
  belongs_to :assigned_staff, class_name: 'User', foreign_key: 'assigned_staff_id'

  before_validation :generate_reference, on: :create

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

  class << self
    def search(query)
      where('subject ILIKE ?', "%#{query}%")
    end
  end

  private

  def generate_reference
    hex_numbers = SecureRandom.hex(3).upcase.scan(/../)
    char_strings = (0..8).map{ (65 + rand(26)).chr }.join.scan(/.../)
    self.reference = char_strings.zip(hex_numbers).flatten.join('-')
  end

end
