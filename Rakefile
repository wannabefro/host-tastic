require 'rake'

task :run do
  pids = [
    spawn('cd management && rails s'),
    spawn('cd customer && ruby server.rb'),
  ]

  trap 'INT' do
    Process.kill 'INT', *pids
    exit 1
  end

  loop do
    sleep 1
  end
end

task :test do
  system("cd management && rspec spec")
end
