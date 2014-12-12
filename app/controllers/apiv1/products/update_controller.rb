class Apiv1::Products::UpdateController < Users::Products::UpdateController
  before_filter :_ensure_product_ownership
  def update
    render json: { product: _toggle_finish_process.call }
  end
  private
  def _toggle_finish_process
    Arrows.lift(_product) >> _decide_finish_or_unfinish >> (_finish_listing! ^ _unfinish_listing!) >> _ember_hashify
  end
  def _ember_hashify
    Arrows.lift -> (product) { product.to_ember_hash }
  end
  def _unfinish_listing!
    Arrows.lift -> (product) { product.tap(&:mark_unfinish!) }
  end
  def _finish_listing!
    Arrows.lift -> (product) { product.tap(&:mark_finish!) }
  end
  def _decide_finish_or_unfinish
    Arrows.lift -> (product) { product.unfinished? ? Arrows.good(product) : Arrows.evil(product) }
  end
  def _ensure_product_ownership
    unless current_user.owns? _product
      render json: { message: "This isn't your listing" }, status: 401
    end
  end
end