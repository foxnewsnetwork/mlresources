class Admin::TaxonFactory
  def initialize(params)
    @params = params
  end
  def satisfy_specifications?
    _taxon.valid?
  end
  def taxon_hash
    { taxon: _taxon.to_ember_hash } 
  end
  def error_hash
    _taxon.errors.to_h
  end
  def save!
    _taxon.tap(&:save!)
  end
  private
  def _taxon
    @taxon ||= Apiv1::Taxon.new _taxon_params
  end
  def _taxon_params
    @params.permit *Apiv1::Taxon::Fields
  end
end