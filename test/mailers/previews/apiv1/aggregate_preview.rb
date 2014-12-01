class Apiv1::AggregatePreview < ActionMailer::Preview
  def summary
    email = Apiv1::NotificationsMailer.new_offer Apiv1::OfferMessage.first
    Apiv1::AggregateMailer.summary [email, email, email]
  end
end