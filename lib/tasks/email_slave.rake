require "generica/email_slave"
namespace :email_slave do
  desc "checks the email job queue for emails that require sending, batches them together, and sends them off"
  task work_the_queue: :environment do
    puts "begin dispatching emails..."
    puts Generica::EmailSlave.new.dispatch_emails!.inspect
    puts "finished"
  end

  desc "just blandly outputs the emails to be sent" 
  task display_the_queue: :environment do

  end
end