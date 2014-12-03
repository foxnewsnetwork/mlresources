God.pid_file_directory = File.expand_path "../../tmp/pids", __FILE__
God.watch do |w|
  w.name = "email_slave"
  w.start = "rake email_slave:work_the_queue"
  # w.env = { "RAILS_ENV" => "production" }
  w.log = File.expand_path "../../log/email_slave.god.log", __FILE__
  w.dir = File.expand_path "../../", __FILE__
  w.keepalive
end