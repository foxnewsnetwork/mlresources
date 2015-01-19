class Apiv1::Taxons::IndexController < Apiv1::HomeController
  def index
    render json: { taxons: _taxons_hash_process.call }
  end
  private
  def _taxons_hash_process
    Arrows.lift(Apiv1::Taxon) >> _taxon_filter_process >= _hashify
  end
  def _hashify
    Arrows.lift lambda(&:to_ember_hash)
  end
  def _taxon_filter_process
    _consider_root_genus >> _consider_heredity >> _consider_ids >> _consider_shipping_ports
  end
  def _consider_root_genus
    _decide_root_genus >> (_by_root_genus ^ Arrows::ID)
  end
  def _decide_root_genus
    Arrows.lift _make_polarizer _root_genus?
  end
  def _root_genus?
    params[:root_genus].present? && 
    params[:root_genus].to_s != "location"
  end
  def _by_root_genus
    Arrows.lift -> (taxons) { taxons.by_root_genus params[:root_genus] }
  end
  def _make_polarizer(condition)
    -> (taxons) { condition ? Arrows.good(taxons) : Arrows.evil(taxons) }
  end
  def _consider_heredity
    _decided_heredity >> (_by_heredity ^ Arrows::ID)
  end
  def _decided_heredity
    Arrows.lift _make_polarizer _heredity?
  end
  def _heredity?
    params.has_key? :parent_id
  end
  def _by_heredity
    _consider_generations >> (_by_first_generation ^ _by_later_generations)
  end
  def _consider_generations
    Arrows.lift _make_polarizer params[:parent_id].blank?
  end
  def _by_first_generation
    Arrows.lift lambda(&:root_generation)
  end
  def _by_later_generations
    Arrows.lift -> (taxons) { taxons.children_of_parent(params[:parent_id]) }
  end
  def _consider_ids
    _decided_ids >> (_by_ids ^ Arrows::ID)
  end
  def _decided_ids
    Arrows.lift _make_polarizer params[:ids].present?
  end
  def _by_ids
    Arrows.lift -> (taxons) { taxons.where id: params[:ids].to_a }
  end
  def _consider_shipping_ports
    Arrows.lift -> (taxons) { taxons.not_shipping_ports }
  end
end