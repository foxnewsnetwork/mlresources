class Apiv1::OfferPostboy
  def initialize(offer)
    @offer = offer
  end

  def request_work!
    _email_objects && _email_request.tap(&:save!)
  end

  private
  def _email_request
    @email_request ||= Apiv1::EmailRequest.new _request_params
  end
  def _email_objects
    @email_objects ||= _email_request.email_objects.new Apiv1::EmailObject.paramify @offer
  end
  def _request_params
    {
      to: _mail.to.first,
      cc: _mail.cc.join(","),
      bcc: _mail.bcc.join(","),
      from: _mail.from.first,
      subject: _mail.subject,
      mailer_class: "Apiv1::NotificationsMailer#new_offer"
    }
  end
  def _mail
    @mail ||= Apiv1::NotificationsMailer.new_offer @offer
  end
end