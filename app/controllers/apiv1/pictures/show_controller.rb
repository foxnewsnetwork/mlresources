class Apiv1::Pictures::ShowController < Apiv1::HomeController
  def show
    render json: { picture: _picture.to_ember_hash }
  end
  private
  def _picture
    @picture ||= Apiv1::Picture.find params[:id]
  end
end