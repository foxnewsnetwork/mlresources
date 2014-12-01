class Apiv1::NotificationsPreview < ActionMailer::Preview
  def new_offer
    Apiv1::NotificationsMailer.new_offer Apiv1::OfferMessage.first
  end
end