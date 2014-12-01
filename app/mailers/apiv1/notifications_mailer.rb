class Apiv1::NotificationsMailer < ActionMailer::Base
  layout 'apiv1/layouts/email'
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_offer.subject
  #
  def new_offer(offer_message)
    @ctx = Apiv1::NotificationsMailer::NewOfferContext.new offer_message

    mail to: @ctx.to,
      from: @ctx.from,
      cc: @ctx.cc,
      bcc: @ctx.bcc,
      subject: @ctx.subject
  end
end
