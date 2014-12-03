namespace :email_slave do
  desc "checks the email job queue for emails that require sending, batches them together, and sends them off"
  task work_the_queue: :environment do
    require "generica/email_slave"
    puts "begin dispatching emails..."
    Generica::EmailSlave.new.dispatch_emails!
    puts "finished"
    sleep 1
  end

end