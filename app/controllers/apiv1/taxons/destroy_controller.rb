class Apiv1::Taxons::DestroyController < Admin::BaseController
  def destroy
    render json: { taxon: _taxon.destroy }
  end
  private
  def _taxon
    @taxon ||= Apiv1::Taxon.find params[:id]
  end
end