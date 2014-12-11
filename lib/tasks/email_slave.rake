require "generica/email_slave"
namespace :email_slave do
  desc "checks the email job queue for emails that require sending, batches them together, and sends them off"
  task work_the_queue: :environment do
    puts "begin dispatching emails..."
    Generica::EmailSlave.new.dispatch_emails!
    puts "finished"
  end

  desc "just blandly outputs the emails to be sent" 
  task display_the_queue: :environment do
    puts Generica::EmailSlave.new.send("_emails").map(&:to_s)
  end
end