class Apiv1::Taxons::ShowController < Apiv1::HomeController
  def show
    render json: { taxon: _taxon.to_ember_hash, taxons: _taxon.children.map(&:to_ember_hash) }
  end
  private
  def _taxon
    @taxon ||= Apiv1::Taxon.find params[:id]
  end
end