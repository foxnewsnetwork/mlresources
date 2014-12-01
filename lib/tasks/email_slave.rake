namespace :email_slave do
  desc "checks the email job queue for emails that require sending, batches them together, and sends them off"
  task work_the_queue: :environment do
    Generica::EmailSlave.dispatch_emails!
  end

  desc "sends a test email"
  task test: :environment do
    require "generica/email_slave"
    email = Apiv1::NotificationsMailer.new_offer Apiv1::OfferMessage.first
    puts email
    Generica::EmailSlave::Dispatcher.dispatch email
  end
end