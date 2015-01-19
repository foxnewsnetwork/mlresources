class Apiv1::Taxons::ShowController < Apiv1::HomeController
  before_filter :not_find_all_location_taxons
  def show
    render json: { taxon: _taxon.to_ember_hash, taxons: _taxon.children.map(&:to_ember_hash) }
  end
  private
  def _taxon
    @taxon ||= Apiv1::Taxon.find params[:id]
  end
  def not_find_all_location_taxons
    if _taxon.root_genus.to_s == "location"
      raise ActiveRecord::RecordNotFound, "no shipping ports"
    end
  end
end