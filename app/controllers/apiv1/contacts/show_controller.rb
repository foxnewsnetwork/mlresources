class Apiv1::Contacts::ShowController < Apiv1::HomeController
  def show
    render json: { contact: _contact.to_ember_hash }
  end
  private
  def _contact
    @contact ||= Apiv1::UserContact.find params[:id]
  end
end