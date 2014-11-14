class Apiv1::Messages::CreateController < Apiv1::HomeController
  def create
    if _message.valid?
      _message.save!
      render json: { message: _message.to_ember_hash }
    else
      render json: _message.errors.to_h, status: :expectation_failed
    end
  end
  private
  def _message
    @message ||= Apiv1::Message.new _message_params
  end
  def _message_params
    params.require(:message).permit(:from_company, :sender_email, :subject_text, :message, :phone_number, :contact_person, :company_address)
  end
end