class Apiv1::Contacts::UpdateController < Apiv1::UsersController
  before_filter :_enforce_correct_user
  def update
    _update_process.call
  end
  private
  def _enforce_correct_user
    unless current_user.admin? || current_user.contacts.include?(_contact)
      render json: { message: "This isn't your listing" }, status: 401
    end
  end
  def _update_process
    _user_inputs >> _apply_changes >> _decide_validity >> (_update_valid_data_process ^ _render_failure)
  end
  def _update_valid_data_process
    _save_changes >> _decide_primality >> (_make_primary ^ Arrows::ID) >> _result_hashify >> _render_success 
  end
  def _user_inputs
    Arrows.lift _contact
  end
  def _apply_changes
    Arrows.lift -> (contact) { contact.tap { |p| p.assign_attributes _contact_params } }
  end
  def _decide_validity
    Arrows.lift -> (contact) { contact.valid? ? Arrows.good(contact) : Arrows.evil(contact) }
  end
  def _decide_primality
    Arrows.lift -> (contact) { params[:contact][:made_primary_at].present? ? Arrows.good(contact) : Arrows.evil(contact) }
  end
  def _result_hashify
    Arrows.lift -> (contact) { { contact: contact.to_ember_hash } }
  end
  def _render_success
    Arrows.lift -> (result_hash) { render json: result_hash }
  end
  def _save_changes
    Arrows.lift -> (contact) { contact.tap(&:save!) }
  end
  def _make_primary
    Arrows.lift -> (contact) { contact.tap &:make_primary! }
  end
  def _render_failure
    Arrows.lift -> (contact) { render json: contact.errors.to_h, status: :expectation_failed }
  end
  def _contact
    @contact ||= Apiv1::UserContact.find params[:id]
  end
  def _contact_params
    @contact_params ||= params.require(:contact).permit(:name, :phone, :email, :address)
  end
end