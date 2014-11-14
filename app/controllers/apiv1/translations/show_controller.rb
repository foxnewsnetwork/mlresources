class Apiv1::Translations::ShowController < Apiv1::HomeController
  def show
    render json: { translation: _translation }
  end
  private
  def _translation
    @translation ||= Apiv1::Translation.find params[:id]
  end
end