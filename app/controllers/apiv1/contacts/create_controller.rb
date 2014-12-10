class Apiv1::Contacts::CreateController < Apiv1::UsersController
  def create
    if _contact_creation_success?
      _contact.save!
      render json: _contact_hash
    else
      render json: _error_hash, status: :expectation_failed
    end
  end
  private
  def _contact_hash
    { contact: _contact.to_ember_hash }
  end
  def _error_hash
    { contact: _contact.errors.to_h }
  end
  def _contact_creation_success?
    _contact.valid?
  end
  def _contact
    @contact ||= current_user.raw_contacts.new _contact_params
  end
  def _contact_params
    params.require(:contact).permit(:name, :phone, :email, :address)
  end
end