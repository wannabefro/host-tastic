class CreateSeedData
  DEPARTMENTS = %w(support general billing business subscription)
  STATES = Ticket.statuses.keys
  def reset
    User.destroy_all
    Department.destroy_all
    Ticket.destroy_all
    Response.destroy_all
    History.destroy_all
  end

  def call
    return if User.count > 0
    begin
    users = FactoryGirl.create_list(:user, 10)
    users << User.create(name: 'Test User', email: 'example@example.com', password: 'password')
    departments = []
    DEPARTMENTS.each do |d|
      departments << FactoryGirl.create(:department, name: d)
    end
    tickets = []
    100.times do
      staff = users.sample
      department = departments.sample
      tickets << FactoryGirl.create(:ticket, department: department, status: STATES.sample, assigned_staff: staff)
    end
    500.times do |n|
      staff = n % 2 == 0 ? users.sample : nil
      FactoryGirl.create(:response, staff: staff, ticket: tickets.sample)
    end
    rescue Exception => e
      reset
      puts "Something went wrong. Please try again"
      puts e
    end
  end
end
