class Apiv1::Taxons::IndexController < Apiv1::HomeController
  def index
    render json: { taxons: _taxons }
  end
  private
  def _taxons
    Apiv1::Taxon.pipeline -> (t) { t.by_root_genus(params[:root_genus]) if params[:root_genus].present? },
      -> (t) { t.children_of_parent(params[:parent_id]) if params[:parent_id].present? },
      -> (t) { t.root_generation if params.has_key?(:parent_id) && params[:parent_id].blank? },
      -> (t) { t.all }
  end
end