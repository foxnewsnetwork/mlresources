class Admin::Taxons::CreateController < Admin::BaseController
  def create
    if _taxon_creation_success?
      _taxon_factory.save!
      render json: _taxon_hash
    else
      render json: _error_hash, status: :expectation_failed
    end
  end
  private
  def _taxon_creation_success?
    _taxon_factory.satisfy_specifications?
  end
  def _taxon_hash
    _taxon_factory.taxon_hash
  end
  def _error_hash
    _taxon_factory.error_hash
  end
  def _taxon_factory
    @taxon_factory ||= Admin::TaxonFactory.new _taxon_params
  end
  def _taxon_params
    params.require(:admin_taxon)
  end
end