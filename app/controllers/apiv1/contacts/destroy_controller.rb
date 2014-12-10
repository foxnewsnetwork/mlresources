class Apiv1::Contacts::DestroyController < Apiv1::Contacts::UpdateController
  def destroy
    render json: _contact.destroy
  end
  private
  def _contact
    @contact ||= Apiv1::UserContact.find(params[:id])
  end
end