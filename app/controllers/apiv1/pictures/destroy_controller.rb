class Apiv1::Pictures::DestroyController < Admin::BaseController
  def destroy
    if _picture.destroy
      render json: _picture.to_ember_hash
    else
      render json: _picture.to_ember_hash, status: :expectation_failed
    end
  end
  private
  def _picture
    @picture ||= Apiv1::Picture.find params[:id]
  end
end