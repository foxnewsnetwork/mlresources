class Admin::TaxonRelationshipsFactory
  def initialize(product, params)
    @product = product
    @taxons = Apiv1::Taxon.find _arrayify params
  end
  def good_relationships
    @good_relationships ||= _good_taxon_ids.map { |id| _existing_relationship(id) || _new_relationship(id) }
  end
  def bad_relationships
    @bad_relationships ||= @product.taxon_relationships.where taxon_id: _bad_taxon_ids
  end  
  private
  def _arrayify(array_like)
    return array_like if array_like.is_a? Array
    array_like.to_a.map(&:last)
  end
  def _existing_relationship(id)
    @product.taxon_relationships.find_by_taxon_id id
  end
  def _new_relationship(id)
    @product.taxon_relationships.new taxon_id: id
  end
  def _good_taxon_ids
    @taxons.map(&:id)
  end
  def _bad_taxon_ids
    _existing_taxon_ids - _good_taxon_ids
  end
  def _existing_taxon_ids
    @product.taxons.map &:id
  end
end