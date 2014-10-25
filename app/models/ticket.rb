class Ticket < ActiveRecord::Base
  belongs_to :department
  belongs_to :assigned_staff, class_name: 'User', foreign_key: 'assigned_staff_id'

  before_validation :generate_reference, on: :create

  enum status: [ :waiting_for_staff_response, :waiting_for_customer, :on_hold, :cancelled, :completed ]

  validates_presence_of :name,
    :email,
    :body,
    :reference,
    :status,
    :department

  def to_params
    reference
  end

  private

  def generate_reference
    hex_numbers = SecureRandom.hex(3).upcase.scan(/../)
    char_strings = (0..8).map{ (65 + rand(26)).chr }.join.scan(/.../)
    self.reference = char_strings.zip(hex_numbers).flatten.join('-')
  end

end
